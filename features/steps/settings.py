from behave import *


@given("duplicate validation is enabled")
def step_impl(context):
    context.account_settings['duplicateValidation'] = True
    # TODO: Also make duplicate validation active for fields
