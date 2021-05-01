@counters
@011
Feature: Counter update scenarios
  General testing of all counter update scenarios

  @011-001
  Scenario: Lead attempt count updates when non-successful outgoing activity is registered
    Given the following lead exists
      | Name  |
      | Tyler |
    When we create an activity like
      | Type | Direction | Call Result | Lead associated | Reference       |
      | Call | Outgoing  | Busy        | Tyler           | My best attempt |
    Then the lead Tyler has been updated to
      | Number of Attempts | Status         |
      | 1                  | On prospection |
    When we delete the activity My best attempt
    Then the lead Tyler has been updated to
      | Number of Attempts |
      | 0                  |

  @011-002
  Scenario: Lead touch count updates when a successful incoming activity is registered
    Given the following lead exists
      | Name  |
      | Tyler |
    When we create an activity like
      | Type | Direction | Call Result     | Lead associated | Reference   |
      | Call | Incoming  | Correct Contact | Tyler           | A nice call |
    Then the lead Tyler has been updated to
      | Number of Touches | Status    |
      | 1                 | Contacted |
    When we delete the activity A nice call
    Then the lead Tyler has been updated to
      | Number of Touches |
      | 0                 |

  @011-003
  Scenario: Company lead counts updates when lead is assigned to it
    Given the following company exists
      | Name      |
      | Aerosmith |
    When we create a lead like
      | Name  | Company   |
      | Tyler | Aerosmith |
    Then the company Aerosmith has been updated to
      | Nº of leads |
      | 1           |
    When we create a lead like
      | Name | Company   |
      | Tom  | Aerosmith |
    Then the company Aerosmith has been updated to
      | Nº of leads |
      | 2           |
    When we delete the lead Tom
    Then the company Aerosmith has been updated to
      | Nº of leads |
      | 1           |
