@crud
@company
Feature: CRUD Company

  Background: We are logged and ready
    Given we are logged in an existing account

  Scenario: Create one company
    When we create a company like
      | Name   | Status    | Target Market  | Source   |
      | Adidas | Contacted | Vacacional | Partners |
    Then the response is 200
    And the response has the bobject id

  Scenario: Get a Company by id
    Given the following company exists
      | Name   | Status |
      | Adidas | New    |
    When we read the company Adidas
    Then the response is 200

  Scenario: Update a company
    Given the following company exists
      | Name   | Status   |
      | Adidas | New |
    When we update the company Adidas with
      | Status |
      | Discarded  |
    Then the company Adidas has been updated to
      | Status |
      | Discarded  |

  Scenario: Delete a company
    Given the following company exists
      | Name   | Country   |
      | Adidas | Argentina |
    When we delete the company Adidas
    Then the company Adidas does not exist
