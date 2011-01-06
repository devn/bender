require 'aruba/cucumber'
require 'mocha'
require File.expand_path(File.join(__FILE__, '../../../lib/bender'))
# require File.expand_path(File.join(__FILE__, '../../../lib/bender/runner'))

World(Mocha::Standalone)

Before do
  mocha_setup
  require 'ruby-debug'
  # Bender.any_instance.stubs(:system).returns(true)
end

After do
  begin
    mocha_verify
  ensure
    mocha_teardown
  end
end
