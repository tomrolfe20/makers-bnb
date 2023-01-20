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
    @space = Space.where("spaces.date_from >= ? AND spaces.date_to <= ? AND spaces.available = ?", params[:date_from], params[:date_to], true)
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
  
  get '/book' do
    return erb(:book)
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

  get '/viewspace/:id' do 
    repo = Space.all
    @space = repo.find(params[:id])
    return erb(:viewspace)
  end

  get '/booking' do
    return erb(:bookings)
  end

  post '/booking' do
    space = Space.find_by(id: params[:space_id])
    return erb(:booking_error) if !space.available
    Booking.create(user_id: params[:user_id], space_id: params[:space_id], date: params[:date])
    return erb(:booking_created)
  end

  get '/confirm' do
    return erb(:confirm)
  end

  post '/confirm' do 
    booking = Booking.find_by(space_id: params[:space_id])
    return erb(:confirm_error) if !booking.available
    Booking.update(user_id: params[:user_id], space_id: params[:space_id], date: params[:date], available: false)
    return erb(:confirmed)
  end

  get '/delete_bookings' do
    return erb(:delete)
  end
  post '/delete_bookings' do 
    Booking.destroy_by(space_id: params[:space_id])
    if Booking.all.length == 0
      return erb(:deleted)
    else Booking.all.length >= 1
      return erb(:deleted_error)
    end 
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
