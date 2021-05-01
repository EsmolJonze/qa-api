Feature: Login

  @unauthenticated
  Scenario: Success Login
    Given we have an existing user
    When the token request attempt is performed
    Then the response is 200
    And the token is delivered
    And the token contains the user's email

  @regression
  @unauthenticated
  Scenario: Failed Login form entering a non existing user
    Given we have a non existing user
    When the token request attempt is performed
    Then the response is 401

  @unauthenticated
  Scenario: Failed Login from entering a correct user and an empty password
    Given we have an existing user but an empty password
    When the token request attempt is performed
    Then the response is 401

  @unauthenticated
  Scenario: Failed Login from entering a correct user but a wrong password
    Given we have an existing user but a wrong password
    When the token request attempt is performed
    Then the response is 401
