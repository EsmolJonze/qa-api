@task
@006
Feature: General testing of all task creating scenarios

  @006-001
  Scenario: Add leads to QC task
    Given the following company exists
      | Name      | Status  |
      | Aerosmith | Backlog |
    When we update the company Aerosmith with
      | Assigned To |
      | QA API |
    Then the company Aerosmith has been updated to
      | Status    |
      | Delivered |
    When we search tasks by
      | Field     | Value           |
      | Company   | Aerosmith       |
      | Task Type | Add Leads to QC |
    Then we get the following tasks
      | Title                     | Status |
      | Search leads of Aerosmith | To Do  |

  @006-002
  Scenario: Ready to prospect
    Given the following company exists
      | Name      | Status    | Assigned To |
      | Aerosmith | Delivered | QA API |
    When we search tasks by
      | Field     | Value           |
      | Company   | Aerosmith       |
      | Task Type | Add Leads to QC |
    Then we get the following tasks
      | Title                     | Status | Reference    |
      | Search leads of Aerosmith | To Do  | Search leads |
    When we update the task Search leads with
      | Status    |
      | Completed |
    Then the company Aerosmith has been updated to
      | Status            |
      | Ready to prospect |

  @006-003
  Scenario: Contact before meeting
    Given the following company exists
      | Name      | Source  |
      | Aerosmith | Inbound |
    When we create an activity like
      | Type    | Company   | User        |
      | Meeting | Aerosmith | QA API |
    When we search tasks by
      | Field     | Value                  |
      | Company   | Aerosmith              |
      | Task Type | Contact Before Meeting |
    Then we get the following tasks
      | Title                  | Status |
      | Contact before Meeting | To Do  |

  @006-004
  Scenario: When a company transitions to Discarded, client or Account its tasks todo are deleted
    Given the following company exists
      | Name      | Status |
      | Aerosmith | New    |
    And the following task exists
      | Company   | Task Type       | Status | Reference    |
      | Aerosmith | Add leads to QC | To Do  | Search leads |
    When we update the company Aerosmith with
      | Status    |
      | Discarded |
    Then the task Search leads does not exist

  @006-005
  # TODO: Check field in admin

