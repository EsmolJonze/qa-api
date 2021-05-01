@on_cascade_delete
@003
Feature: On cascade delete

  @003-002
  Scenario: When a company is deleted its activities, leads and tasks are deleted
    Given the following company exists
      | Name  | Status    | Assigned To | Target Market      | Source  |
      | Slack | Delivered | QA API | Larga | Inbound |
    When we delete the company Slack
    And we search activities by
      | Field   | Value |
      | Company | Slack |
    Then the search is empty
    And we search leads by
      | Field   | Value |
      | Company | Slack |
    Then the search is empty
    And we search tasks by
      | Field   | Value |
      | Company | Slack |
    Then the search is empty
