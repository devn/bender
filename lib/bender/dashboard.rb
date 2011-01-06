require 'sinatra/base'

class Bender
  class Dashboard < Sinatra::Base
    get '/' do
      'Hello world!'
    end
  end
end
