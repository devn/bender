Feature: Dashboard Landing
  In order to tell that my application is working
  As a concerned developer
  I want (need) to see "Hello World" to feel secure

  Scenario: I see my comfort message on the server (all is well)
    Given I am on the homepage
    Then I should see "Hello world"
