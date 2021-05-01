@crud
@activity
Feature: CRUD Activity

  Background: We are logged and ready
    Given we are logged in an existing account

  Scenario: Create one activity
    When we create a activity like
      | Type | Direction |
      | Call | Outgoing  |
    Then the response is 200
    And the response has the bobject id

  Scenario: Find an activity by id
    Given the following activity exists
      | Type | Direction | Reference     |
      | Call | Outgoing  | Business Call |
    When we read the activity Business Call
    Then the response is 200
    And the response has the bobject id

  Scenario: Update an activity
    Given the following activity exists
      | Type | Direction | Reference     |
      | Call | Outgoing  | Business Call |
    When we update the activity Business Call with
      | Direction |
      | Incoming  |
    Then the activity Business Call has been updated to
      | Type | Direction |
      | Call | Incoming  |

  Scenario: Delete an activity
    Given the following activity exists
      | Type | Direction | Reference     |
      | Call | Outgoing  | Business Call |
    When we delete the activity Business Call
    Then the activity Business Call does not exist
