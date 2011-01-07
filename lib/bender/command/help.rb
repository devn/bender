module Bender::Command
  class Help < Base

    def default
      puts "usage: bender <command> [options] [arguments]"
      puts
      puts "Commands:"
      commands.each do |command|
        puts "    %-19s %s" % [command.name.split('::')[-1].downcase, command.help_summary]
      end
      puts
      puts "Run bender <command> --help for help with a given command"
    end

    class << self

      def help_summary
      end

    end
  end
end
