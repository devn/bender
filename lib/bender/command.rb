require 'bender/command/base'

Dir["#{File.dirname(__FILE__)}/command/*.rb"].each do |c|
  require c
end

module Bender
  module Command

    def run args
      command = args.shift.strip rescue 'help'
      run_internal command, args.dup
    end

    def run_internal command, args
      klass, method = parse(command)
      runner = klass.new(args)
      runner.send(method) if runner.respond_to?(method)
    end

    def parse command
      parts = command.split(':')
      case parts.size
      when 1
        return eval("Bender::Command::#{command.capitalize}"), :default
      else
        const = Bender::Command
        command = parts.pop
        parts.each { |part| const = const.const_get(part.capitalize) }
        return const, command.to_sym
      end
    end

  end
end
