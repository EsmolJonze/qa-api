@notifications
@010
Feature: Notifications
  General testing of all notification scenarios

#  @010-001a
#  Scenario: New inbound lead
#    Given the following company exists
#      | Name        | Assigned To |
#      | Nickelodeon | QA API      |
#    And the following lead exists
#      | Name  | Status | Leads source |
#      | Tyler | New    | Inbound      |
#    When we update the lead Tyler with
#      | Company |
#      | Slack   |
#    Then we get the following notification
#      | Title                    | Subtitle | Category |
#      | Inbound lead Tyler added | Slack    | Inbound  |
#
#  @010-001b
#  Scenario: New inbound lead without company
#    Given QA API is the default notification user
#    When we create an lead like
#      | Name  | Status | Leads source |
#      | Tyler | New    | Inbound      |
#    Then we get the following notification
#      | Title                            | Subtitle | Category |
#      | New Inbound lead without company | Tyler    | Inbound  |

  @010-002
  Scenario: Email from lead
    Given the following company exists
      | Name      | Assigned To |
      | Aerosmith | QA API      |
    And the following lead exists
      | Name  | Company   |
      | Tyler | Aerosmith |
    When we create an activity like
      | Type  | Direction | Lead associated |
      | Email | Incoming  | Tyler           |
    Then we get the following notification
      | Title            | Subtitle  | Category |
      | Email from Tyler | Aerosmith | Updates  |

  @010-003
  Scenario: LinkedIn message from lead
    Given the following company exists
      | Name      | Assigned To |
      | Aerosmith | QA API      |
    And the following lead exists
      | Name  | Company   |
      | Tyler | Aerosmith |
    When we create an activity like
      | Type             | Direction | Lead associated |
      | LinkedIn Message | Incoming  | Tyler           |
    Then we get the following notification
      | Title                       | Subtitle  | Category |
      | LinkedIn message from Tyler | Aerosmith | Updates  |

  @010-004a
  Scenario: Inbound activity from lead
    Given the following company exists
      | Name      | Assigned To |
      | Aerosmith | QA API      |
    And the following lead exists
      | Name  | Company   |
      | Tyler | Aerosmith |
    When we create an activity like
      | Type    | Lead associated |
      | Inbound | Tyler           |
    Then we get the following notification
      | Title                       | Subtitle  | Category |
      | Inbound activity from Tyler | Aerosmith | Inbound  |

  @010-004b
  Scenario: Inbound activity from lead via acquisition form
    Given the following company exists
      | Name      | Assigned To |
      | Aerosmith | QA API      |
    And the following lead exists
      | Name  | Company   | Acquisition form |
      | Tyler | Aerosmith | Ebook            |
    When we create an activity like
      | Type    | Lead associated |
      | Inbound | Tyler           |
    Then we get the following notification
      | Title                                 | Subtitle  | Category |
      | Inbound activity from Tyler           | Aerosmith | Inbound  |
