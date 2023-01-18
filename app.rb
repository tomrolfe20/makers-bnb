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

  get '/signup' do
   
    return erb(:signup)
  end

  post '/signup' do
    # User.create(user_name: "name31", email: "name31@example.email", password_digest: "pass1234")
    # User.create(user_name: params[:user_name], email: params[:email], password_digest: params[:password_digest])
    # @user.user_name = params[:user_name]
    # @user.email = params [:email]
    # @user.password_digest = params[:password_digest]
    @user = User.all

    @user.each do |record|
    if record.user_name.include?(params[:user_name]) || record.email.include?(params[:email])
      return erb(:signup_error)
    end

    User.create(user_name: params[:user_name], email: params[:email], password_digest: params[:password_digest])
    # @users.create(user)
    
    return erb(:user_added)
    end
  end

end
