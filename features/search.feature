Feature: Searches

  Scenario: Search leads by one picklist value
    Given the following company exist
      | Name   |
      | School |
    And the following leads exist
      | Name    | Status    | Company |
      | Alberto | Meeting   | School  |
      | Benito  | Discarded | School  |
      | Carlos  | Meeting   | School  |
      | Diego   | Meeting   | School  |
      | Eudald  | Discarded | School  |
    When we search leads by
      | Field   | Value   | Sort      |
      | Status  | Meeting |           |
      | Company | School  |           |
      | Name    |         | Ascending |
    Then we get the following leads
      | Name    | Status  |
      | Alberto | Meeting |
      | Carlos  | Meeting |
      | Diego   | Meeting |

  Scenario: Search leads by multiple picklist values
    Given the following company exist
      | Name   |
      | School |
    And the following leads exist
      | Name    | Status    | Company |
      | Alberto | Meeting   | School  |
      | Benito  | Discarded | School  |
      | Carlos  | Contacted | School  |
      | Diego   | Meeting   | School  |
      | Eudald  | Discarded | School  |
    When we search leads by
      | Field   | Value     | Sort      |
      | Status  | Meeting   |           |
      | Status  | Contacted |           |
      | Company | School    |           |
      | Name    |           | Ascending |
    Then we get the following leads
      | Name    |
      | Alberto |
      | Carlos  |
      | Diego   |


  Scenario: Search leads by two fields
    Given the following company exist
      | Name   |
      | School |
    And the following leads exist
      | Name    | Status    | Leads source | Company |
      | Alberto | Meeting   | Inbound      | School  |
      | Benito  | Discarded | Outbound     | School  |
      | Carlos  | Meeting   | Outbound     | School  |
      | Diego   | Meeting   | Inbound      | School  |
      | Eudald  | Discarded | Outbound     | School  |
    When we search leads by
      | Field        | Value   | Sort      |
      | Status       | Meeting |           |
      | Leads source | Inbound |           |
      | Company      | School  |           |
      | Name         |         | Ascending |
    Then we get the following leads
      | Name    | Status  |
      | Alberto | Meeting |
      | Diego   | Meeting |

  Scenario: Search leads by name autocomplete
    Given the following company exist
      | Name   |
      | School |
    And the following leads exist
      | Name    | Company |
      | Alberto | School  |
      | Benito  | School  |
      | Carlos  | School  |
    When we search leads by
      | Field   | Value  | Mode         | Sort      |
      | Company | School |              |           |
      | Name    | A      | Autocomplete | Ascending |
    Then we get the following leads
      | Name    |
      | Alberto |

  # TODO: Check when wipe data runs before scenario
  @wip
  Scenario: Search companies by name autocomplete
    Given control step
      | Field | Value | Mode         | Sort      |
      | Name  | A     | Autocomplete | Ascending |
    Given the following companies exist
      | Name        |
      | ACDC        |
      | Led Zepelin |
    When we search companies by
      | Field | Value | Mode         | Sort      |
      | Name  | A     | Autocomplete | Ascending |
    Then we get the following companies
      | Name      |
      | ACDC      |


  Scenario: Search leads by full name autocomplete
    Given the following company exist
      | Name   |
      | School |
    And the following leads exist
      | Name    | Surname | Company |
      | Alberto | Perez   | School  |
      | Benito  | Palotes | School  |
      | Carlos  | Arenas  | School  |
    When we search leads by
      | Field     | Value  | Mode         | Sort      |
      | Company   | School |              |           |
      | Full name | A      | Autocomplete | Ascending |
    Then we get the following leads
      | Name    |
      | Alberto |
      | Carlos  |

  Scenario: Search leads by full name with multiple letters autocomplete
    Given the following company exist
      | Name   |
      | School |
    And the following leads exist
      | Name    | Surname | Company |
      | Alberto | Perez   | School  |
      | Benito  | Palotes | School  |
      | Carlos  | Alenas  | School  |
    When we search leads by
      | Field     | Value  | Mode         | Sort      |
      | Company   | School |              |           |
      | Full name | Al     | Autocomplete | Ascending |
    Then we get the following leads
      | Name    |
      | Alberto |
      | Carlos  |

