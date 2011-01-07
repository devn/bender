require 'bender/command/base'

module Bender::Command
  class Pair < Base

    def default
      pair_info = hitch_info
      if pair_info
        puts pair_info
      else
        puts hitch_error
      end
    end

    protected

    def hitch_available?
      begin
        require 'hitch'
        true
      rescue LoadError
        false
      end
    end

    def hitch_names
      Hitch.send(:git_author_name)
    end

    def hitch_emails
      Hitch.send(:git_author_email)
    end

    def hitch_info
      hitch_available? ? "#{hitch_names} <#{hitch_emails}>" : nil
    end

    def hitch_error
      'No pair info available!\n  (add hitch to your project)\n\n --OR-- \n\n fork me and hack away!'
    end

  end
end
