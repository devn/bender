module Bender::Command
  class Info < Base

    def default
      # banner_arguments "[format]"

      # on "--full", "default format" do |full|
        # @format = :full
      # end

      # on "--summary", "summary view containing current statistics" do |raw|
        # @format = :summary
      # end

      case @args.size
      when 0
        puts "'info' outputs information about a specific command and its usage"
        puts "usage: bender info <command>"
      else
        something
      end
    end

    def something
      puts 'blah'
    end

    class << self

      def help_summary
        "additional information about specific commands"
      end

    end

  end
end
