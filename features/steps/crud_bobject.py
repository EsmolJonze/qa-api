from behave import *

from features.steps.utils.bobject import read_bobject, delete_bobject, update_bobject, create_bobject, compare_fields
from features.steps.utils.decorators import wait, retry, normalize
from features.steps.utils.table import row_to_dict

use_step_matcher('re')


@given("the following (?P<bobject_type>company|lead|task|activity|companies|leads) exists?")
@normalize()
def step_impl(context, bobject_type):
    create_bobject(context, bobject_type)


@when('we create (?:an? )?(?P<bobject_type>company|lead|task|activity|opportunity) like')
@normalize()
def step_impl(context, bobject_type):
    create_bobject(context, bobject_type)


@when('we delete the (?:company|lead|task|activity) (?P<reference>.*)')
@normalize()
@wait(5)
def step_impl(context, reference):
    reference_manager = context.reference_manager
    bobject_id = reference_manager.get_id(reference)
    bobject_type = reference_manager.get_bobject_type(reference)
    delete_bobject(context, bobject_id, bobject_type)


@when("we update the (?:company|lead|task|activity) (?P<reference>.*) with")
@wait(3)  # TODO: When the trigger's race conditions are solved remove this sleep
def step_impl(context, reference):
    reference_manager = context.reference_manager
    bobject_id = reference_manager.get_id(reference)
    bobject_type = reference_manager.get_bobject_type(reference)
    update_bobject(context, bobject_id, bobject_type)


@when("we read the (?:company|lead|task|activity) (?P<reference>.*)")
def step_impl(context, reference):
    reference_manager = context.reference_manager
    bobject_id = reference_manager.get_id(reference)
    bobject_type = reference_manager.get_bobject_type(reference)
    read_bobject(context, bobject_id, bobject_type)


@then("the (?:company|lead|task|activity) (?P<reference>.*) has been updated to")
@retry(attempts=5)
def step_impl(context, reference):
    reference_manager = context.reference_manager
    bobject_id = reference_manager.get_id(reference)
    bobject_type = reference_manager.get_bobject_type(reference)
    read_bobject(context, bobject_id=bobject_id, bobject_type=bobject_type)
    current_fields = context.last_response.json()['fields']
    expected_fields = row_to_dict(context.table[0])
    for label, value in expected_fields.items():
        compare_fields(label, value, current_fields)
