from assertpy import assert_that, fail
from dateparser import parse as parse_date


def row_to_dict(row):
    return {row.headings[i]: row.cells[i] for i in range(len(row))}


def table_to_array(table):
    return [row_to_dict(row) for row in table]


def table_to_bobject_fields(context, bobject_type):
    data_model = context.data_model
    reference_manager = context.reference_manager
    table = table_to_array(context.table)
    contents = []
    for row in table:
        content = {}
        for name, value in row.items():
            if name == 'Reference':
                content['Reference'] = value
            elif not data_model.does_field_exist(bobject_type, name):
                similar_field_name = data_model.get_similar_field(bobject_type, name)
                fail(f"Field '{name}' does not exist in {bobject_type}. Maybe you meant '{similar_field_name}'")
            elif data_model.is_picklist_field(bobject_type, name):
                if value != '' and not data_model.does_picklist_value_exist(bobject_type, name, value):
                    similar_value = data_model.get_similar_picklist_value(bobject_type, name, value)
                    fail(f"'{value}' doesn't exist in picklist '{name}'. Maybe you meant '{similar_value}'")
                field_id = data_model.get_field_id(bobject_type, name)
                value_id = data_model.get_picklist_value_id(bobject_type, name, value)
                content[field_id] = value_id
            elif data_model.is_reference_field(bobject_type, name):
                assert_that(value in reference_manager).is_true()
                reference_id = reference_manager.get_long_id(value)
                content[name] = reference_id
            elif data_model.is_date_field(bobject_type, name):
                content[name] = parse_date(value).strftime("%Y-%m-%dT%H:%M:%SZ")
            else:
                content[name] = value
        contents.append(content)
    return contents


search_mode_translation = {
    'Autocomplete': 'AUTOCOMPLETE__SEARCH',
    'Exact': 'EXACT__SEARCH',
}


def table_to_search(context, bobject_type):
    data_model = context.data_model
    reference_manager = context.reference_manager
    table = table_to_array(context.table)
    query = {}
    sort = []
    for row in table:
        field_name = row['Field']
        field_value = row['Value']
        search_mode = row.get('Mode')
        sorting = row.get('Sort')

        if not data_model.does_field_exist(bobject_type, field_name):
            similar_field_name = data_model.get_similar_field(bobject_type, field_name)
            fail(f"Field '{field_name}' does not exist in {bobject_type}. Maybe you meant '{similar_field_name}'")

        field_id = data_model.get_field_id(bobject_type, field_name)

        if sorting:
            assert_that(sorting).is_in('Ascending', 'Descending')
            direction = 'ASC' if sorting == 'Ascending' else 'DESC'
            sort.append({
                'field': field_id,
                'direction': direction
            })

        if field_value != '':
            assert_that(search_mode).is_in(*search_mode_translation.keys(), '', None)
            search_mode = search_mode_translation.get(search_mode, None)

            value_id = None
            if data_model.is_picklist_field(bobject_type, field_name):
                value_id = data_model.get_picklist_value_id(bobject_type, field_name, field_value)
            elif data_model.is_text_field(bobject_type, field_name):
                value_id = field_value
            elif data_model.is_reference_field(bobject_type, field_name):
                assert_that(field_value in reference_manager).is_true()
                value_id = reference_manager.get_long_id(field_value)
                search_mode = search_mode or search_mode_translation['Exact']
            elif data_model.is_date_field(bobject_type, field_name):
                value_id = parse_date(field_value).strftime("%Y-%m-%dT%H:%M:%SZ")
            if field_id in query:
                query[field_id]['query'].append(value_id)
            else:
                query[field_id] = {
                    'query': [value_id],
                    'searchMode': search_mode
                }
    return query, sort
