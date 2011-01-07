module Bender::Command
  class Templates < Base

    def default
      case @args.size
      when 0
        Dir.glob(File.join(bender.project_path, '**', '*.template')).each {|file| puts file}
      else
        # too_many
      end
    end

    class << self

      def help_summary
        "List config files with templates"
      end

    end
  end
end
