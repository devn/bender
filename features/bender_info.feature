Feature: Info Command
  In order to get practical info about bender state
  As a user
  I want help

  Scenario: bender info
    Given I run "bender info"
    Then the output should contain "info"
      And the output should contain "usage: bender info <command>"

  # Scenario: bender info --summary
    # Given I run "bender info --summary"
    # Then the output should contain "bender plugins:"
      # And the output should contain "git"

  # Scenario: bender info git
    # Given I run "bender info git"
    # Then the output should contain "bender plugins:"
      # And the output should contain "git"

    # bender info git
    # bender info git --summary
    # bender info git submodules
    # bender info git submodules --remote
    # bender info git submodules --no-update --remote
    # bender info git --no-update submodules --remote
    # bender -f info
    # bender git refresh
    # bender git
    # bender git show
