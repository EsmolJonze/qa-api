@status
@005
Feature: Change status activity creation

  @005-001
  Scenario: Changing company status generates status change activities
    Given the following company exists
      | Name      | Status | Assigned To |
      | Aerosmith | New    | QA API |
    When we update the company Aerosmith with
      | Status    |
      | Delivered |
    And we search activities by
      | Field                | Value                  |
      | Company              | Aerosmith              |
      | Status activity type | Company Status Changed |
    Then we get the following activities
      | Status Title                         |
      | Company status changed to Delivered. |


#  @005-002
#  Scenario: Lead added
#    Given the following company exists
#      | Name      | Status | Assigned To |
#      | Aerosmith | New    | QA API |
#    When we create an lead like
#      | Name | Company   |
#      | Liv  | Aerosmith |
#    And we search activities by
#      | Field                | Value          |
#      | Company              | Aerosmith      |
#      | Status activity type | New Lead Added |
#    Then we get the following activities
#      | Status Title              |
#      | New lead added to company |

  @005-003
  Scenario: Company assigned
    Given the following company exists
      | Name      | Status |
      | Aerosmith | New    |
    When we update the company Aerosmith with
      | Assigned To |
      | QA API |
    And we search activities by
      | Field                | Value            |
      | Company              | Aerosmith        |
      | Status activity type | Company Assigned |
    Then we get the following activities
      | Status Title                        |
      | Company was assigned to QA API |

  @005-004
  Scenario: Company created
    Given the following company exists
      | Name      | Status |
      | Aerosmith | New    |
    When we search activities by
      | Field                | Value           |
      | Company              | Aerosmith       |
      | Status activity type | Company Created |
    Then we get the following activities
      | Status Title    |
      | Company created |

  @005-005
  Scenario: Lead created
    Given the following company exists
      | Name      | Status |
      | Aerosmith | New    |
    And the following lead exists
      | Name | Company   |
      | Liv  | Aerosmith |
    When we search activities by
      | Field                | Value            |
      | Company              | Aerosmith        |
      | Status activity type | New Lead Created |
    Then we get the following activities
      | Status Title     |
      | New lead created |
