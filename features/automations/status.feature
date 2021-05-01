@status
@002
Feature: Status Change
  General testing of all status transferring scenarios

  @002-001
  Scenario: Attempt activity updates lead to status "On prospection"
    Given the following lead exists
      | Name  | Status |
      | Tyler | New    |
    When we create an activity like
      | Type | Direction | Call Result | Lead associated |
      | Call | Outgoing  | Busy        | Tyler           |
    Then the lead Tyler has been updated to
      | Status         |
      | On prospection |

  @002-002
  Scenario: Touch activity updates lead to status "Contacted"
    Given the following lead exists
      | Name  | Status |
      | Tyler | New    |
    When we create an activity like
      | Type | Direction | Call Result     | Lead associated |
      | Call | Outgoing  | Correct Contact | Tyler           |
    Then the lead Tyler has been updated to
      | Status    |
      | Contacted |

  @002-003
  Scenario: Meeting activity updates lead to status "Meeting"
    Given the following lead exists
      | Name  |
      | Tyler |
    # TODO: on status before Engaged, or Discarded, or Nurturing
    When we create an activity like
      | Type    | Lead associated |
      | Meeting | Tyler           |
    Then the lead Tyler has been updated to
      | Status  |
      | Meeting |

  @002-004
  Scenario: Lead created in company in "Delivered" then company to "Finding leads"
    Given the following company exists
      | Name      | Status    | Assigned To |
      | Aerosmith | Delivered | QA API |
    When we create a lead like
      | Name  | Company   |
      | Tyler | Aerosmith |
    Then the company Aerosmith has been updated to
      | Status        |
      | Finding leads |

  @002-005a
  Scenario: If company is "Discarded" and lead belonging to it updates to "Meeting", company also updates to "Meeting"
    Given the following company exists
      | Name      | Status    | Assigned To |
      | Aerosmith | Discarded | QA API |
    And the following lead exists
      | Name  | Company   |
      | Tyler | Aerosmith |
    When we update the lead Tyler with
      | Status  |
      | Meeting |
    Then the company Aerosmith has been updated to
      | Status  |
      | Meeting |

  @002-005b
  Scenario: If company is "Nurturing" and lead belonging to it updates to "Meeting", company also updates to "Meeting"
    Given the following company exists
      | Name      | Status    | Assigned To |
      | Aerosmith | Nurturing | QA API |
    And the following lead exists
      | Name  | Company   |
      | Tyler | Aerosmith |
    When we update the lead Tyler with
      | Status  |
      | Meeting |
    Then the company Aerosmith has been updated to
      | Status  |
      | Meeting |

#  @wip
#  @002-007
#  Scenario: When we assign an opportunity to a company, if the company status is not "Account" or "Client", its status goes to "Account"
#    Given the following company exists
#      | Name      |
#      | Aerosmith |
#    When we create an opportunity like
#      | Company   |
#      | Aerosmith |
#    Then the company Aerosmith has been updated to
#      | Status  |
#      | Account |
#
#  @wip
#  @002-008
#  Scenario: When an opportunity status updates to "Closed won", then company updates to status "Client"
#    Given the following company exists
#      | Name      |
#      | Aerosmith |
#    When we create an opportunity like
#      | Company   | Status     |
#      | Aerosmith | Closed won |
#    Then the company Aerosmith has been updated to
#      | Status |
#      | Client |

  @002-009
  Scenario: Company to Nurturing all leads not Discarded go to nurturing
    Given the following company exists
      | Name        |
      | Presocratic |
    And the following leads exist
      | Name        | Status    | Company     |
      | Hermocrates | Contacted | Presocratic |
      | Diogenes    | Discarded | Presocratic |
    When we update the company Presocratic with
      | Status    |
      | Nurturing |
    Then the lead Hermocrates has been updated to
      | Status    |
      | Nurturing |
    And the lead Diogenes has been updated to
      | Status    |
      | Discarded |

  @002-010
  Scenario: When a company with leads assigned to it changes it's status to Discarded, then all the leads are Discarded
    Given the following company exists
      | Name        | Status    | Target Market | Source   |
      | Presocratic | Delivered | Media         | Outbound |
    And the following lead exists
      | Name     | Company     |
      | Socrates | Presocratic |
    When we update the company Presocratic with
      | Status    |
      | Discarded |
    Then the lead Socrates has been updated to
      | Status    |
      | Discarded |

  @status-date
  @002-011a
  Scenario: When company changes to status "Meeting", the "Meeting Status Date" is filled with the date when status changed
    Given the following company exists
      | Name        | Status    |
      | Presocratic | Delivered |
    When we update the company Presocratic with
      | Status  |
      | Meeting |
    Then the company Presocratic has been updated to
      | Meeting Status Date |
      | Now                 |

  @status-date
  @002-011b
  Scenario: When lead changes to status "Meeting", the "Meeting Status Date" is filled with the date when status changed
    Given the following lead exists
      | Name     | Status |
      | Socrates | New    |
    When we update the lead Socrates with
      | Status  |
      | Meeting |
    Then the lead Socrates has been updated to
      | Meeting Status Date |
      | Now                 |

#  @wip
#  @002-012a
#  Scenario: When the Company changes to status X, if all previous statuses don't have status date, they are filled with the same status date as the X_status_date
#    Given the following company exists
#      | Name | Status    | Assigned To |
#      | Nike | Delivered | QA API |
#    When we update the company Nike with
#      | Status    |
#      | Contacted |
#    And we search companies by
#      | Field                     | Value       | Sort      |
#      | Name                      | Nike        |           |
#      | Status                    | Contacted   |           |
#      | Assigned To               | QA API | Ascending |
#      | Delivered Status Date     | Today        |           |
#      | Finding leads Status Date | Today       |           |
#      | Contacted Status Date     | Today       |           |
#    Then we get the following companies
#      | Name | Status    |
#      | Nike | Contacted |

#  @wip
#  @002-012b
#  Scenario: When the lead changes to status X, if all previous statuses don't have status date, they are filled with the same status date as the X_status_date
#    Given the following lead exists
#      | Name     |
#      | Socrates |
#    When we update the lead Socrates with
#      | Status    |
#      | Contacted |
#    And we search leads by
#      | Field                      | Value     | Sort |
#      | Name                       | Socrates  |      |
#      | Status                     | Contacted |      |
##      | On prospection Status Date | Today      |      |
#      | Contacted Status Date      | Today     |      |
#    Then we get the following leads
#      | Name     |
#      | Socrates |
  @wip
  @002-013
  Scenario: When the Company changes to status previous to X, the later statuses except for Nurturing, Discarded, Contact, Account and Client, are removed
    Given the following company exists
      | Name      | Assigned To | Status    |
      | Aerosmith | QA API | Contacted |
    When we update the company Aerosmith with
      | Status    |
      | Delivered |
    And we search companies by
      | Field               | Value     |
      | Name                | Aerosmith |
      | On Prospection Date | Now     |
    Then the search is empty

