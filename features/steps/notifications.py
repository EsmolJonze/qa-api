from assertpy import assert_that
from behave import *

from features.steps.utils.decorators import wait
from features.steps.utils.request import get_json, patch_json, delete_json
from features.steps.utils.string import to_upper_snake_case
from features.steps.utils.table import row_to_dict

use_step_matcher("re")


@then("we get the following notification")
@wait(5)
def step_impl(context):
    data = row_to_dict(context.table[0])
    category = to_upper_snake_case(data['Category'])
    url = f"{context.web_url}/notifications?category={category}&size=1&page=0"
    response = get_json(context, url)
    notification = response.json()['content'][0]
    assert_that(notification['title'].strip()).is_equal_to(data['Title'].strip())
    assert_that(notification['subtitle'].strip()).is_equal_to(data['Subtitle'].strip())
    # Delete notification afterwards
    url = f"{context.web_url}/notifications/{notification['id']}"
    response = delete_json(context, url)
    assert_that(response.status_code).is_equal_to(204)


@given("(?P<user>.*) is the default notification user")
def step_impl(context, user):
    url = f"{context.rest_url}/accounts/{context.account_id}"
    # Trick to get the user id from the name
    user_id = context.data_model.get_picklist_value_id('Company', 'Assigned To', user)
    body = {
        'defaultNotificationUser': 'defaultNotificationUsers/' + user_id
    }
    response = patch_json(context, url, body)
    assert_that(response.status_code).is_equal_to(200)
