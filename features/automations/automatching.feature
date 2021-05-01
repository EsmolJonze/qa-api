#@009
#@wip
## TODO: These won't work untill wipe data is performed because of duplicated emails
#Feature: Automatching
#  General testing of Company assignment related issues
#
#  @009-001
#  Scenario: Assign leads to companies by email
#    Given the following company exists
#      | Name      | Website      | Assigned To |
#      | Bloobirds | bloobrds.com | QA API |
#    When we create a lead like
#      | Name    | Email                |
#      | Algodon | aurelio@bloobrds.com |
#    And we search leads by
#      | Field   | Value     | Mode         | Sort      |
#      | Company | Bloobirds |              |           |
#      | Name    | A         | Autocomplete | Ascending |
#    Then we get the following leads
#      | Name    | Email                |
#      | Algodon | aurelio@bloobrds.com |
#
#
#  @009-002
#  Scenario: Assign inbound activities to leads
#    Given the following company exists
#      | Name   |
#      | Pirate |
#    Given the following lead exists
#      | Name    | Email            | Company |
#      | Aurelia | aureli@gmail.com | Pirate  |
#    When we create an activity like
#      | Type  | Inbound Lead email |
#      | Email | aureli@gmail.com   |
#    And we search activities by
#      | Field   | Value  |
#      | Company | Pirate |
#      | Type    | Email  |
#    Then we get the following activities
#      | Type  |
#      | Email |
