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
  enable :sessions
  configure :development do
    register Sinatra::ActiveRecordExtension
    register Sinatra::Reloader
  end
  get '/search' do
    return erb(:search)
  end 

  post '/search' do
    @space = Space.where("spaces.date_from >= ? AND spaces.date_to <= ?", params[:date_from], params[:date_to])
    return erb(:viewspaces)
  end 

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

  get '/login' do
    return erb(:login)
  end
  
  get '/signup' do
    return erb(:signup)
  end
  get '/login' do 
    return erb(:login)
  end
  get '/spaces' do
    return erb(:listspace)
  end
  get '/viewspaces' do 
    @space = Space.all
    return erb(:viewspaces)
  end

  get '/viewspaces/:id' do 
    repo = Space.all
    @space = repo.find(params[:id])

    return erb(:viewspace)
  end

  post '/spaces' do
    Space.create(name: params[:name], description: params[:description], price_per_night: params[:price_per_night], date_from: params[:date_from], date_to: params[:date_to], user_id: session[:user_id])
    return erb(:createdspace)
  end 

  post '/signup' do
    return erb(:signup_error) if username_exists(params[:user_name]) || email_exists(params[:email])
    User.create(user_name: params[:user_name], email: params[:email], password: params[:password])
    erb(:user_added)
  end

  post '/login' do
    username = params[:user_name]
    password = params[:password]
    if user = User.find_by(user_name: username)
      if user.password == password
        session[:user_id] = user.id
        return erb(:loggedin)
      else
        return erb(:login_error)
      end
    else
      return erb(:login_error)
    end
  end

  post '/logout' do
    session.clear
    return erb(:logout)
  end
end
