from assertpy import assert_that
from behave import *

from features.steps.utils.bobject import read_bobject
from features.steps.utils.decorators import normalize, retry

use_step_matcher('re')


@then('the response is (?P<status_code>\d{3})')
def step_impl(context, status_code):
    assert_that(str(context.last_response.status_code)).is_equal_to(status_code)


@then("the response has the bobject id")
def step_impl(context):
    bobject = context.last_response.json()
    bobject_id = bobject.get('objectId', None)
    if not bobject_id:
        bobject_id = bobject['id']['objectId']
    assert_that(bobject_id).is_not_none()
    assert_that(bobject_id).is_length(16)


@then("the (?:company|lead|task|activity) (?P<reference>.*) does not exist")
@retry(attempts=5)
@normalize()
def step_impl(context, reference):
    reference_manager = context.reference_manager
    bobject_id = reference_manager.get_id(reference)
    bobject_type = reference_manager.get_bobject_type(reference)
    read_bobject(context, bobject_id, bobject_type)
    status_code = str(context.last_response.status_code)
    assert_that(status_code).is_equal_to('404')
