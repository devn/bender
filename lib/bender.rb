require 'yaml'

class Bender

  class Error < RuntimeError
  end

  autoload :Runner,  'bender/runner'

  def self.config
    @config ||= {}.merge(
      if File.exist?(path = File.expand_path('~/.tracker.yml'))
        YAML.load_file(path)
      end || {}
    )
  end

  def self.hash_to_xml(root, attributes)
    require 'cgi'
    xml = "<#{root}>"
    attributes.each do |k,v|
      if v.kind_of?(Hash)
        xml << hash_to_xml(k, v)
      else
        xml << "<#{k}>#{CGI.escapeHTML(v.to_s)}</#{k}>"
      end
    end
    xml << "</#{root}>"
  end

  def self.run(argv)
    Runner.new(argv).run
  end

  attr_reader :directory

  def initialize(path = '.')
    @lang = 'en'
    @directory = File.expand_path(path)
    until File.directory?(File.join(@directory,'doc/bender'))
      if @directory == File.dirname(@directory)
        raise Error, 'Project not found.  Make sure you have a doc/bender/ directory.', caller
      end
      @directory = File.dirname(@directory)
    end
  end

  def project_path(*subdirs)
    File.join(@directory,*subdirs)
  end

  def config_file
    project_path('.bendrc') || project_path('config/.bendrc')
  end

  def config
    @config ||= File.exist?(config_file) && YAML.load_file(config_file) || {}
    self.class.config.merge(@config)
  end

  def real_name
    config["real_name"] || (require 'etc'; Etc.getpwuid.gecos.split(',').first)
  end

  def project
    @project ||= Dir.chdir(@directory) do
    end
  end

  def format
    (config['format'] || :tag).to_sym
  end
end
