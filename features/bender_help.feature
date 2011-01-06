Feature: Help Command
  In order to ensure usability
  As a user
  I want help

  Scenario: bender help
    Given I run "bender help"
    Then the output should contain "usage: bender <command> [options] [arguments]"
      And the exit status should be 0
