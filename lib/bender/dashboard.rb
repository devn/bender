require 'sinatra/base'
require 'git'
require 'haml'

class Bender
  class Dashboard < Sinatra::Base
    get '/' do
      @git = Git.open(File.expand_path(File.join(__FILE__, '../../../')))
      haml :index
    end
  end
end
