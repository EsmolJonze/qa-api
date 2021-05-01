@012
Feature: Assign company
  General testing of Company assignment related issues

  @012-001
  Scenario: Assign Backlog company to user
    Given the following company exists
      | Name      | Status  |
      | Bloobirds | Backlog |
    When we update the company Bloobirds with
      | Assigned To |
      | QA API      |
    Then the company Bloobirds has been updated to
      | Name      | Status    |
      | Bloobirds | Delivered |


  @012-002
  Scenario: Company Reassignment
    Given the following company exists
      | Name      | Status    | Assigned To |
      | Bloobirds | Delivered | QA API |
    When we update the company Bloobirds with
      | Assigned To |
      | Mario       |
    Then the company Bloobirds has been updated to
      | Name      | Assigned To |
      | Bloobirds | Mario       |

#  @wip
#  @012-003
#  Scenario: Reassign company to None
#    Given the following company exists
#      | Name      | Status    | Assigned To |
#      | Bloobirds | Delivered | QA API |
#    When we update the company Bloobirds with
#      | Assigned To |
#      |             |
#    Then the company Bloobirds has been updated to
#      | Name      | Status  |
#      | Bloobirds | Backlog |

