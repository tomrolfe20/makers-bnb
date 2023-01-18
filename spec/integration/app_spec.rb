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

  context 'POST /signup' do
    it 'should create a new user' do
      @response = post('/signup', user_name: 'name99', email: 'name99@example.email', password_digest: 'pass1234')
      expect(User.last.user_name).to include('name99')
    end
  end

  context 'POST /signup' do
    it 'should fail if duplicate email' do
      post('/signup', user_name: 'name31', email: 'name33@example.email', password_digest: 'pass1234')
      @response = post('/signup', user_name: 'name31', email: 'name33@example.email', password_digest: 'pass1234')
      


      expect(@response.body).to include("This Username or email is already in use")

    end
  end
end
