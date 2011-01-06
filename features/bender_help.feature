Feature: Help Command
  In order to ensure usability
  As a user
  I want help

  Scenario: bender help
    Given I run "bender help"
    Then the output should contain "usage: bender <command> [options] [arguments]"
      And the output should contain "Commands:"
      And the output should contain "info"
      And the output should contain "templates"
      And the exit status should be 0
