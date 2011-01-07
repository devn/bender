require 'bender/command/base'

module Bender::Command
  class Pair < Base

    class << self
      def help_summary
        "Lord and Overseer of all things that pair"
      end
    end

    def default
      if hitch_available?
        case @args.size
        when 0
          puts pair_info
        else
          if @args[0] == '-u' || @args[0] == '--unpair'
            unpair
          else
            pair @args
          end
        end
      else
        puts hitch_error
      end
    end

  protected

    def hitch_available?
      begin
        require 'hitch'
        @pair_class = Hitch
        true
      rescue LoadError
        false
      end
    end

    def hitch_names
      @pair_class.send(:git_author_name)
    end

    def hitch_emails
      @pair_class.send(:git_author_email)
    end

    def hitch_info
      "#{hitch_names} <#{hitch_emails}>"
    end

    def unpair
      case @pair_class.name
      when "Hitch"
        @pair_class.send(:unhitch)
      else
        nil
      end
    end

    def pair args
      case @pair_class.name
      when "Hitch"
        @pair_class.send(:export, args)
      else
        nil
      end
    end

    def pair_info
      case @pair_class.name
      when "Hitch"
        hitch_info
      else
        nil
      end
    end

    def pair_error
      case @pair_class.name
      when "Hitch"
        hitch_error
      else
        nil
      end
    end

    def hitch_error
      "No pair info available!\n\n  add hitch to your project\n     --OR-- \n  fork me and hack away!"
    end
  end
end
