import requests

from features.steps.utils.array import find
from features.steps.utils.string import similar_words_score


class DataModel:
    def __init__(self, context):
        url = f"{context.web_url}/service/datamodel"
        headers = {
            'content-type': 'application/json',
            'accept': 'application/json',
            'authorization': 'Bearer ' + context.token
        }
        response = requests.get(url, headers=headers)
        bobject_models = response.json()['types']
        self.bobjects = {}
        for bobject in bobject_models:
            self.bobjects[bobject['name']] = bobject['fields']

    def get_field_id(self, bobject_type, field_name):
        field = self.get_field(bobject_type, field_name)
        return field['id']

    def get_similar_field(self, bobject_type, field_name):
        fields = self.bobjects[bobject_type]
        names = map(lambda f: f['name'], fields)
        return max(names, key=lambda name: similar_words_score(name, field_name))

    def get_similar_picklist_value(self, bobject_type, field_name, field_value):
        field = self.get_field(bobject_type, field_name)
        values = map(lambda f: f['name'], field['values'])
        return max(values, key=lambda name: similar_words_score(name, field_value))

    def does_field_exist(self, bobject_type, field_name):
        field = self.get_field(bobject_type, field_name)
        return field is not None

    def does_picklist_value_exist(self, bobject_type, field_name, field_value):
        field = self.get_field(bobject_type, field_name)
        value = find(lambda x: x['name'] == field_value, field['values'])
        return value is not None

    def is_reference_field(self, bobject_type, field_name):
        field = self.get_field(bobject_type, field_name)
        return field['fieldType'] == 'REFERENCE'

    def is_picklist_field(self, bobject_type, field_name):
        field = self.get_field(bobject_type, field_name)
        return field['fieldType'] == 'PICKLIST' or field['fieldType'] == 'GLOBAL_PICKLIST'

    def is_text_field(self, bobject_type, field_name):
        field = self.get_field(bobject_type, field_name)
        return field['fieldType'] == 'TEXT'

    def is_date_field(self, bobject_type, field_name):
        field = self.get_field(bobject_type, field_name)
        return field['fieldType'] == 'DATETIME' or field['fieldType'] == 'DATE'

    def get_picklist_value_id(self, bobject_type, field_name, field_value):
        field = self.get_field(bobject_type, field_name)
        picklist_values = field['values']
        desired_value = find(lambda x: x['name'].lower() == field_value.lower(), picklist_values)
        return desired_value['id']

    def get_field(self, bobject_type, field_name):
        fields = self.bobjects[bobject_type]
        return find(lambda f: f['name'] == field_name, fields)
