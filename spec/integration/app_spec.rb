require "spec_helper"
require "rack/test"
require_relative '../../app'
require 'json'
require_relative '../../lib/user'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  # Write your integration tests below.
  # If you want to split your integration tests
  # accross multiple RSpec files (for example, have
  # one test suite for each set of related features),
  # you can duplicate this test file to create a new one.

  after(:each) { expect(@response.status).to eq 200 }

  context 'GET /' do
    it 'should get the homepage' do
      @response = get('/')
      expect(@response.body).to include('Hello')
    end
  end
  context 'GET /login' do
    it 'should return a log in form' do
      @response = get('/login')
      expect(@response.body).to include('<input type="text" name="user_name" placeholder="username">')
      expect(@response.body).to include('<input type="password" name="password" placeholder="password">')
      #if using speech marks within the inlcude then you need singlar mark on the outside - see above.
    end
  end 
  context 'GET /spaces' do 
    it 'should return a list space form' do 
      @response = get('/spaces')
      expect(@response.body).to include('<input type="text" name="name" placeholder="space name">')
      expect(@response.body).to include('<input type="text" name="description" placeholder="description">')
      expect(@response.body).to include('<input type="text" name="price_per_night" placeholder="PPN">')
      expect(@response.body).to include('<input type="text" name="date_from" placeholder="2023-01-01">')
      expect(@response.body).to include('<input type="text" name="date_to" placeholder="2023-01-04">')
    end
  end 
  context 'GET /viewspaces' do
    it 'should return a list of spaces' do 
      @response = get('/viewspaces')
      expect(@response.body).to include("Hotel Makers")
    end
  end 
  context 'POST /signup' do
    it 'should create a new user' do
      length = User.all.length
      @response = post('/signup', user_name: 'hello', email: 'hello@example.email', password: 'hello')
      expect(User.last.user_name).to include('hello')
      expect(length + 1).to eq(User.all.length)
      User.last.destroy
    end
  end
  context 'POST /signup with same email' do
    it 'should fail and return error' do
      length = User.all.length
      @response = post('/signup', user_name: 'name', email: 'name@example.email', password: 'pass123')
      expect(@response.body).to include('This Username or email is already in use')
      expect(length).to eq(User.all.length)
    end
  end

  context 'POST /login' do
    it 'should log the user in' do
      @response = post('/login', user_name: 'name', password: 'pass123')
      expect(@response.body).to include("You have logged in")
    end 
  end 
  context 'POST /login with wrong password' do
    it 'should give us an error' do
      @response = post('/login', user_name: 'name', password: 'notpass123')
      expect(@response.body).to include("You have entered the wrong details")
    end
  end

  context 'POST /logout' do
    it 'should log you out of the session' do
      @response = post('/logout')
      expect(@response.body).to include("You have logged out")
    end
  end
  context 'POST /spaces' do 
    it 'should create a new space for a user' do
      @response = post('/spaces', name: "Hotel well", description: "It's alright", price_per_night: 200, date_from: "2022-01-01", date_to: "2022-01-04", user_id: 1)
      expect(@response.body).to include("Space created")
    end 
  end
  context 'POST /search' do 
    xit 'should search based upon dates' do
      @response = post('/search', date_from: '2022-01-01', date_to: '2022-01-03')
      expect(@response.body).to include("Hotel Makers")
    end
  end
  context 'POST /booking' do 
    it 'should create new booking' do
      @response = post('/booking', user_id: 2, space_id: 3, date: '2023-01-01', available: false)
      expect(@response.body).to include("Booking created")
    end
  end 
  context 'POST /booking' do
    it 'should send an error if not avilable' do 
      @response = post('/booking', user_id: 1, space_id: 1, date: '2023-01-01')
      expect(@response.body).to include("Cant book for this date")
    end
  end
  
end
