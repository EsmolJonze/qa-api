from assertpy import assert_that
from dateparser import parse as parse_date

from features.steps.utils.array import find
from features.steps.utils.request import post_json, get_json, delete_json, patch_json
from features.steps.utils.table import table_to_bobject_fields, table_to_search


def build_content_body(context, data):
    return {
        'contents': data,
        'params': {
            'duplicateValidation': context.account_settings['duplicateValidation']
        }
    }


def create_bobject(context, bobject_type):
    reference_manager = context.reference_manager
    contents = table_to_bobject_fields(context, bobject_type)
    url = f"{context.bobject_url}/{context.account_id}/{bobject_type}"
    responses = []
    for content in contents:
        reference_name = content.pop('Reference', None)
        body = build_content_body(context, content)
        response = post_json(context, url, body)
        if reference_name:
            reference_manager.save(reference_name, response.json())
        elif 'Name' in content:
            reference_manager.save(content['Name'], response.json())
        responses.append(response)
    context.last_response = responses[-1]
    context.responses = responses


def read_bobject(context, bobject_id, bobject_type):
    url = f"{context.bobject_url}/{context.account_id}/{bobject_type}/{bobject_id}/form"
    context.last_response = get_json(context, url)


def update_bobject(context, bobject_id, bobject_type):
    reference_manager = context.reference_manager
    content = table_to_bobject_fields(context, bobject_type)[0]
    url = f"{context.bobject_url}/{context.account_id}/{bobject_type}/{bobject_id}/raw"
    reference_name = content.pop('Reference', None)
    body = build_content_body(context, content)
    response = patch_json(context, url, body)
    if reference_name:
        reference_manager.save(reference_name, response.json())
    elif 'Name' in content:
        reference_manager.save(content['Name'], response.json())
    context.last_response = response


def delete_bobject(context, bobject_id, bobject_type):
    url = f"{context.bobject_url}/{context.account_id}/{bobject_type}/{bobject_id}"
    context.last_response = delete_json(context, url)


def search_bobject(context, bobject_type):
    query, sort = table_to_search(context, bobject_type)
    url = f"{context.bobject_url}/{context.account_id}/{bobject_type}/search"
    body = {
        'formFields': True,
        'injectReferences': True,
        'page': 0,
        'pageSize': 50,
        'query': query,
        'sort': sort,
    }
    context.last_response = post_json(context, url, body)


def compare_fields(label, value, fields):
    field = find(lambda f: f['label'] == label, fields)
    if field['type'] == 'NUMBER':
        if float(value) == 0.0 and 'text' not in field:  # 0 values are not sent in the response
            return
        assert_that(float(field['text'])).is_equal_to(float(value))
    elif field['type'] == 'DATETIME' or field['type'] == 'DATE':
        date_field = parse_date(field['text'])
        date_value = parse_date(value)
        assert_that(date_field.date()).is_equal_to(date_value.date())
    else:
        assert_that(field['text']).is_equal_to(value)
