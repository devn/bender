require 'sinatra/base'
require 'git'
require 'haml'
require 'sass'

module Bender
  class Dashboard < Sinatra::Base
    root_dir = File.join(File.dirname(__FILE__), %w(.. .. dashboard))
    set :root, root_dir
    get '/' do
      @git = Git.open(Dir.pwd)
      haml :index, {:layout => :'layouts/application'}
    end

    get '/screen.css' do
      content_type 'text/css'
      sass :'sass/screen'
    end
  end
end
