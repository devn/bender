require 'bender/dashboard'

module Bender::Command
  class Dashboard < Base

    def default
      Bender::Dashboard.run! :host => 'localhost', :port => 4567
    end

  end
end
