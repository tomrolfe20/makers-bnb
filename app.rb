# in app.rb
require "sinatra/base"
# an extra gem to require
require "sinatra/activerecord"
require "sinatra/reloader"
require_relative "./lib/user"
require_relative "./lib/space"
require_relative "./lib/booking"

# BCrypt for encrypting the passwords
require "bcrypt"

class Application < Sinatra::Base

  configure :development do
    register Sinatra::ActiveRecordExtension
    register Sinatra::Reloader
  end

  get '/' do
    @user = User.all
    return erb(:index)
  end

  # get '/all' do
  #   @user = User.all
  #   return erb(:index)
  # end
end
