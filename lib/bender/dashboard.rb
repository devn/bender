require 'sinatra/base'

class Bender::Dashboard < Sinatra::Base
  get '/' do
    'Hello world!'
  end
end
