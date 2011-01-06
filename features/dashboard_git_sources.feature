Feature: Dashboard Git Sources
  In order to tell that my code is safe and secure
  As a concerned developer
  I want (need) to see my source repository in the dashboard

  Scenario: I see my git repository remote source on the server
    Given I am on the homepage
    Then I should see the git source path
