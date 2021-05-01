@cadence
@wip
@001
Feature: Cadence

  @001-001
  Scenario: Install tasks
    Given the following company exists
      | Name      | Status | Target Market | Assigned To |
      | Bloobirds | New    | Larga         | QA API      |
    And the following lead exists
      | Name  | Company   |
      | Pablo | Bloobirds |
    When we update the company Bloobirds with
      | Status         |
      | On Prospection |
    And we search tasks by
      | Field          | Value            | Sort      |
      | Company        | Bloobirds        |           |
      | Task Type      | Prospect Cadence |           |
      | Scheduled Date |                  | Ascending |
    Then we get the following tasks
      | Title       | Scheduled Date | Is action LinkedIn message | Is action email | Is action call |
      | 2nd Attempt | Tomorrow       | Yes                        | Yes             | Yes            |
      | 3rd Attempt | In 2 days      |                            |                 | Yes            |
      | 4th Attempt | In 3 days      |                            | Yes             | Yes            |

  @001-002
  Scenario: Delete cadence tasks
    Given the following company exists
      | Name      | Status | Target Market | Assigned To |
      | Bloobirds | New    | Larga         | QA API      |
    And the following lead exists
      | Name  | Company   |
      | Pablo | Bloobirds |
    When we update the company Bloobirds with
      | Status         |
      | On Prospection |
    And we search tasks by
      | Field          | Value            | Sort      |
      | Company        | Bloobirds        |           |
      | Task Type      | Prospect Cadence |           |
      | Scheduled Date |                  | Ascending |
    Then we get the following tasks
      | Title       | Scheduled Date | Is action LinkedIn message | Is action email | Is action call | Reference   |
      | 2nd Attempt | Tomorrow       |                            |                 | Yes            | 2th Attempt |
      | 3rd Attempt | In 2 days      |                            |                 | Yes            | 3rd Attempt |
      | 4th Attempt | In 3 days      |                            | Yes             | Yes            | 4th Attempt |
    When we delete the task 3rd Attempt
    And we search tasks by
      | Field          | Value            | Sort      |
      | Company        | Bloobirds        |           |
      | Task Type      | Prospect Cadence |           |
      | Scheduled Date |                  | Ascending |
    Then we get the following tasks
      | Title       | Scheduled Date | Is action LinkedIn message | Is action email | Is action call |
      | 2nd Attempt | Tomorrow       |                            |                 | Yes            |
      | 4th Attempt | In 3 days      |                | Yes             | Yes            |

  @001-003
  Scenario: Reschedule Cadence
    Given the following company exists
      | Name      | Status | Target Market | Assigned To |
      | Bloobirds | New    | Vacacional    | QA API      |
    And the following lead exists
      | Name  | Company   |
      | Pablo | Bloobirds |
    When we update the company Bloobirds with
      | Status         |
      | On Prospection |
    And we update the company Bloobirds with
      | Start cadence date |
      | In 7 days          |
    And we search tasks by
      | Field          | Value            | Sort      |
      | Company        | Bloobirds        |           |
      | Task Type      | Prospect Cadence |           |
      | Scheduled Date |                  | Ascending |
    Then we get the following tasks
      | Title        | Scheduled Date | Is action LinkedIn message | Is action email | Is action call |
      | 2nd Attempt | In 8 days        | Yes                        | Yes             | Yes            |
      | 3rd Attempt | In 9 days      |                            |                 | Yes            |
      | 4th Attempt | In 10 days      |                            | Yes             | Yes            |




