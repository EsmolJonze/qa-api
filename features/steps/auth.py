import jwt
from assertpy import assert_that
from behave import *

from features.steps.utils.request import post_json


@given("we are logged in an existing account")
def step_impl(context):
    context.token = context.token
    context.account_id = context.account_id


@given("we have an existing user")
def step_impl(context):
    context.body = {
        'email': 'testdialer@bloobirds.com',
        'password': 'ecef3d25bf4c2f8bd8baea60c6d46f32e817caae9648929f2d3750a3257c4b7ef3fbccb06390190545df3fff4f7a5175cc603ba29883fbe6c53931f0ae92c312',
        'claimerSystem': 'WEB_APP'
    }


@when("the token request attempt is performed")
def step_impl(context):
    url = f"{context.jwt_url}/service/jwt"
    context.last_response = post_json(context, url, context.body)


@then("the token is delivered")
def step_impl(context):
    context.token = context.last_response.json()['token']
    assert_that(context.token).is_not_none().is_type_of(str)


@step("the token contains the user's email")
def step_impl(context):
    decoded_token = jwt.decode(context.token, verify=False)
    assert_that(decoded_token).is_not_none()
    assert_that(decoded_token['userEmail']).is_equal_to(context.body['email'])


@given("we have a non existing user")
def step_impl(context):
    context.body = {
        'email': 'nonexisting@bloobirds.com',
        # tesla sha512 hashed :D
        'password': 'ecef3d25bf4c2f8bd8baea60c6d46f32e817caae9648929f2d3750a3257c4b7ef3fbccb06390190545df3fff4f7a5175cc603ba29883fbe6c53931f0ae92c312',
        'claimerSystem': 'WEB_APP'
    }


@given("we have an existing user but an empty password")
def step_impl(context):
    context.body = {
        'email': 'testdialer@bloobirds.com',
        'password': '',
        'claimerSystem': 'WEB_APP'
    }


@given("we have an existing user but a wrong password")
def step_impl(context):
    context.body = {
        'email': 'testdialer@bloobirds.com',
        'password': 'tasla',
        'claimerSystem': 'WEB_APP'
    }
