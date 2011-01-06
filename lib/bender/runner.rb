require 'optparse'

class Bender
  class Runner
    class Base
      attr_reader :argv

      def initialize(argv)
        @argv = argv
        @tty = $stdout.tty?
        @opts = OptionParser.new
        @opts.version = "0.0.1"
        @opts.banner = "Usage: bender #{self.class.command_name} #{self.class.banner_arguments}"
        @opts.base.long["help"] = OptionParser::Switch::NoArgument.new do
          help = @opts.help.chomp.chomp + "\n"
          help += "\n#{self.class.description}" if self.class.description
          puts help
          @exit = 0
        end
        @opts.separator("")
      end

      def self.options
        @options ||= []
      end

      def self.on(*args, &block)
        options << args
        define_method("option_#{args.object_id}", &block)
      end

      def self.banner_arguments(value = nil)
        if value
          @banner_arguments = value
        else
          @banner_arguments || (arity.zero? ? "" : "...")
        end
      end

      def self.summary(value = nil)
        if value
          @summary = value
        else
          @summary
        end
      end

      def self.description(value = nil)
        if value
          @description = value
        else
          @description || "#@summary."
        end
      end

      def self.command_name
        name.split('::').last.gsub(/(.)([A-Z])/) {"#$1-#$2"}.downcase
      end

      def self.method_name
        command_name.gsub('-','_')
      end

      def self.process(&block)
        define_method(:process, &block)
      end

      def self.arity
        instance_method(:process).arity
      end

      def arity
        self.class.arity
      end

      def bender
        @bender ||= Bender.new(Dir.getwd)
      end

      def abort(message)
        raise Error, message
      end

      def too_many
        abort "too many arguments"
      end

      def run
        self.class.options.each do |arguments|
          @opts.on(*arguments, &method("option_#{arguments.object_id}"))
        end
        begin
          @opts.parse!(@argv)
        rescue OptionParser::InvalidOption
          abort $!.message
        end
        return @exit if @exit
        minimum = arity < 0 ? -1 - arity : arity
        if arity >= 0 && arity < @argv.size
          too_many
        elsif minimum > @argv.size
          abort "not enough arguments"
        end
        process(*@argv)
      end

      def process(*argv)
        bender.send(self.class.method_name,*argv)
      end

      def color?
        case bender.config["color"]
        when "always" then true
        when "never"  then false
        else
          @tty && RUBY_PLATFORM !~ /mswin|mingw/
        end
      end

      def colorize(code, string)
        if color?
          "\e[#{code}m#{string}\e[00m"
        else
          string.to_s
        end
      end

      def paginated_output
        stdout = $stdout
        if @tty && pager = bender.config["pager"]
          # Modeled after git
          ENV["LESS"] ||= "FRSX"
          IO.popen(pager,"w") do |io|
            $stdout = io
            yield
          end
        else
          yield
        end
      rescue Errno::EPIPE
      ensure
        $stdout = stdout
      end

    end

    def self.[](command)
      klass_name = command.to_s.capitalize.gsub(/[-_](.)/) { $1.upcase }
      if klass_name =~ /^[A-Z]\w*$/ && const_defined?(klass_name)
        klass = const_get(klass_name)
        if Class === klass && klass < Base
          return klass
        end
      end
    end

    def self.commands
      constants.map {|c| Runner.const_get(c)}.select {|c| Class === c && c < Runner::Base}.sort_by {|r| r.command_name}.uniq
    end

    def self.command(name, &block)
      const_set(name.to_s.capitalize.gsub(/[-_](.)/) { $1.upcase },Class.new(Base,&block))
    end

    command :info do
      banner_arguments "[format]"
      summary "Show project info"

      on "--full", "default format" do |full|
        @format = :full
      end

      on "--summary", "summary view containing current statistics" do |raw|
        @format = :summary
      end

      process do |*args|
        case args.size
        when 0
          puts "Bender Project"
        else
          too_many
        end
      end
    end

    command :templates do
      summary "List config files with templates"

      process do |*args|
        case args.size
        when 0
          Dir.glob(File.join(bender.project_path, '**', '*.template')).each {|file| puts file}
        else
          too_many
        end
      end
    end

    def initialize(argv)
      @argv = argv
    end

    COLORS = {
      :black   => 0,
      :red     => 1,
      :green   => 2,
      :yellow  => 3,
      :blue    => 4,
      :magenta => 5,
      :cyan    => 6,
      :white   => 7
    }

    def run
      command = @argv.shift
      if klass = self.class[command]
        result = klass.new(@argv).run
        exit result.respond_to?(:to_int) ? result.to_int : 0
      elsif ['help', '--help', '-h', '', nil].include?(command)
        puts "usage: bender <command> [options] [arguments]"
        puts
        puts "Commands:"
        self.class.commands.each do |command|
          puts "    %-19s %s" % [command.command_name, command.summary]
        end
        puts
        puts "Run bender <command> --help for help with a given command"
      else
        raise Error, "Unknown bender command #{command}"
      end
    rescue Bender::Error
      $stderr.puts "#$!"
      exit 1
    rescue Interrupt
      $stderr.puts "Interrupted!"
      exit 130
    end

  end
end
