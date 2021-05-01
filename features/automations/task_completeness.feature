@task
@004
Feature: Task completeness

#  @004-001
#  Scenario: Autocomplete tasks on first attempt
#    Given the following company exists
#      | Name   | Status            | Assigned To |
#      | Adidas | Ready to prospect | QA API |
#    And the following lead exists
#      | Name | Company |
#      | Paco | Adidas  |
#    And we search tasks by
#      | Field     | Value         |
#      | Company   | Adidas        |
#      | Task Type | Start Cadence |
#    And we get the following tasks
#      | Task Type     | Reference     |
#      | Start Cadence | First attempt |
#    When we create an activity like
#      | Type | Direction | Call Result | Lead associated |
#      | Call | Outgoing  | Busy        | Paco            |
#    # TODO: Alternative update future action to past instead of trigger this manually
#    And we update the task First attempt with
#      | Complete task ping |
#      | Yes                |
#    Then the task First attempt has been updated to
#      | Status    |
#      | Completed |

  @004-003
  Scenario: Inactive companies
    Given the following company exist
      | Name   | Assigned To |
      | Adidas | QA API |
    And the following lead exists
      | Name | Company |
      | Paco | Adidas  |
    When we update the company Adidas with
      | Status    |
      | Contacted |
    When we search tasks by
      | Field     | Value           |
      | Company   | Adidas          |
      | Task Type | Add Leads to QC |
    And we get the following tasks
      | Task Type       | Status | Reference    |
      | Add leads to QC | To Do  | Search leads |
    And we update the task Search leads with
      | Status    |
      | Completed |
    Then the company Adidas has been updated to
      | Company without future tasks |
      | Yes                          |
