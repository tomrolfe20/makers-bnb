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
end
