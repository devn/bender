require 'sinatra/base'
require 'git'
require 'haml'

module Bender
  class Dashboard < Sinatra::Base
    set :root, File.join(File.dirname(__FILE__), '../../')
    get '/' do
      @git = Git.open(Dir.pwd)
      haml :index
    end
  end
end
