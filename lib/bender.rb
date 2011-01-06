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

























  # :stopdoc:
  LIBPATH = ::File.expand_path(::File.dirname(__FILE__)) + ::File::SEPARATOR
  PATH = ::File.dirname(LIBPATH) + ::File::SEPARATOR
  # :startdoc:

  # Returns the version string for the library.
  #
  def self.version
    @version ||= File.read(path('version.txt')).strip
  end

  # Returns the library path for the module. If any arguments are given,
  # they will be joined to the end of the libray path using
  # <tt>File.join</tt>.
  #
  def self.libpath( *args, &block )
    rv =  args.empty? ? LIBPATH : ::File.join(LIBPATH, args.flatten)
    if block
      begin
        $LOAD_PATH.unshift LIBPATH
        rv = block.call
      ensure
        $LOAD_PATH.shift
      end
    end
    return rv
  end

  # Returns the lpath for the module. If any arguments are given,
  # they will be joined to the end of the path using
  # <tt>File.join</tt>.
  #
  def self.path( *args, &block )
    rv = args.empty? ? PATH : ::File.join(PATH, args.flatten)
    if block
      begin
        $LOAD_PATH.unshift PATH
        rv = block.call
      ensure
        $LOAD_PATH.shift
      end
    end
    return rv
  end

  # Utility method used to require all files ending in .rb that lie in the
  # directory below this file that has the same name as the filename passed
  # in. Optionally, a specific _directory_ name can be passed in such that
  # the _filename_ does not have to be equivalent to the directory.
  #
  def self.require_all_libs_relative_to( fname, dir = nil )
    dir ||= ::File.basename(fname, '.*')
    search_me = ::File.expand_path(
        ::File.join(::File.dirname(fname), dir, '**', '*.rb'))

    Dir.glob(search_me).sort.each {|rb| require rb}
  end

end  # module Bender

Bender.require_all_libs_relative_to(__FILE__)
