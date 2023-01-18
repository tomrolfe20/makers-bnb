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

  # def invalid_input
  #   # status 400
  #   erb(:signup_error)
  # end

  def username_exists(username)
    User.find_by(user_name: username)
  end

  def email_exists(email)
    User.find_by(email: email)
  end

  get '/' do
    @user = User.all
    return erb(:index)
  end

  get '/signup' do
    return erb(:signup)
  end

  post '/signup' do
    return erb(:signup_error) if username_exists(params[:user_name]) || email_exists(params[:email])
    User.create(user_name: params[:user_name], email: params[:email], password: params[:password])
    erb(:user_added)
  end

end
