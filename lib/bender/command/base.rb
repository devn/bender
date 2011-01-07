require 'optparse'

module Bender::Command
  class Base

    def initialize args = []
      @args = args
    end

    def command_names
      Dir["#{File.dirname(__FILE__)}/*.rb"].collect do |c|
        c.split('/')[-1].sub('.rb','').capitalize
      end
    end

    def commands
      command_names.collect {|c| eval("Bender::Command::#{c}") }
    end

    class << self

      def summary
      end

    end
  end
end
