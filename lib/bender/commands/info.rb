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
        puts "Bender Project"
      else
        # too_many
      end
    end

    class << self

      def summary
        "Show project info"
      end

    end

  end
end
