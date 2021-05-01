@duplicates
@007
Feature: Duplicate Checking

  Background: Account duplicate validation is enabled when creating and updating bobjects
    Given duplicate validation is enabled

  @007-001
  Scenario: Companies by name
    Given the following company exists
      | Name   | Website        |
      | Adidas | www.adidas.com |
    When we create an company like
      | Name   | Website             |
      | Adidas | www.nikewannabe.com |
    Then the response is 409

  @007-002a
  Scenario: Companies by website
    Given the following company exists
      | Name   | Website        |
      | Adidas | www.adidas.com |
    When we create an company like
      | Name      | Website        |
      | Adidas SL | www.adidas.com |
    Then the response is 409

  @007-002b
  Scenario: Companies by website (http)
    Given the following company exists
      | Name   | Website        |
      | Adidas | www.adidas.com |
    When we create an company like
      | Name      | Website               |
      | Adidas SL | http://www.adidas.com |
    Then the response is 409

  @007-002c
  Scenario: Companies by website (https)
    Given the following company exists
      | Name   | Website        |
      | Adidas | www.adidas.com |
    When we create an company like
      | Name      | Website                |
      | Adidas SL | https://www.adidas.com |
    Then the response is 409

  @007-002d
  Scenario: Companies by website (www)
    Given the following company exists
      | Name   | Website        |
      | Adidas | www.adidas.com |
    When we create an company like
      | Name      | Website    |
      | Adidas SL | adidas.com |
    Then the response is 409

  @007-003
  Scenario: Leads by name
    Given the following lead exists
      | Name | Email           |
      | Jeff | jeff@amazon.com |
    When we create an lead like
      | Name | Email              |
      | Jeff | jeffrey@amazon.com |
    Then the response is 409

  @007-004
  Scenario: Leads by email
    Given the following lead exists
      | Name | Email           |
      | Jeff | jeff@amazon.com |
    When we create an lead like
      | Name       | Email           |
      | Jeff Bezos | jeff@amazon.com |
    Then the response is 409
