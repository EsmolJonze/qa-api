@crud
@lead
Feature: CRUD Lead

  Background: We are logged and ready
    Given we are logged in an existing account

  Scenario: Create lead
    When we create a lead like
      | Name     |
      | Socrates |
    Then the response is 200
    And the response has the bobject id

  Scenario: Get a lead by id
    Given the following lead exists
      | Name  |
      | Plato |
    When we read the lead Plato
    Then the response is 200

  Scenario: Update a lead
    Given the following lead exists
      | Name  | Leads source |
      | Plato | Inbound      |
    When we update the lead Plato with
      | Leads source |
      | Outbound     |
    Then the lead Plato has been updated to
      | Leads source |
      | Outbound     |

  Scenario: Delete a lead
    Given the following lead exists
      | Name  |
      | Plato |
    When we delete the lead Plato
    Then the lead Plato does not exist
