from assertpy import assert_that
from behave import *

from features.steps.utils.bobject import search_bobject, compare_fields
from features.steps.utils.decorators import normalize, wait
from features.steps.utils.table import table_to_array

use_step_matcher('re')


@step("we search (?P<bobject_type>companies|leads|activities|tasks) by")
@normalize()
@wait(3)
def step_impl(context, bobject_type):
    search_bobject(context, bobject_type)


@step("we get the following (?P<bobject_type>companies|leads|activities|tasks)")
@normalize()
def step_impl(context, bobject_type):
    response = context.last_response.json()
    reference_manager = context.reference_manager
    table = table_to_array(context.table)
    if context.initial_value:
        total_matching = response['totalMatching'] - context.initial_value
        print(total_matching)
    else:
        total_matching = response['totalMatching']

    assert_that(total_matching).described_as('Matched bobjects in last search').is_equal_to(len(table))

    bobjects = response['contents']
    for row, bobject in zip(table, bobjects):
        for name, value in row.items():
            if name == 'Reference' and value:
                reference_manager.save(value, bobject)
            elif value:
                compare_fields(name, value, bobject['fields'])


@then("the search is empty")
def step_impl(context):
    response = context.last_response.json()
    total_matching = response['totalMatching']
    assert_that(total_matching).is_equal_to(0)


@given("control step")
def step_impl(context):
    search_bobject(context, "Company")
    response = context.last_response.json()
    context.initial_value = response['totalMatching']