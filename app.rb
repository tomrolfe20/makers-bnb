# in app.rb
require "sinatra/base"
# an extra gem to require
require "sinatra/activerecord"
require "sinatra/reloader"

# BCrypt for encrypting the passwords
require "bcrypt"

class Maker < Sinatra::Base

  configure :development do
    register Sinatra::ActiveRecordExtension
    register Sinatra::Reloader
  end



  get '/' do
    return erb(:index)
  end

  get '/all' do

    return erb(:index)
  end
end
