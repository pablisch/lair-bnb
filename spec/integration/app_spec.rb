require "spec_helper"
require "rack/test"
require_relative '../../app'
require 'json'

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


  context 'GET /' do
    it 'should get the homepage' do
      response = get('/')

      expect(response.status).to eq(200)
      expect(response.body).to include('Welcome to Flair BnB')
    end
  end

  context 'GET /spaces/:id' do
    it 'should get the spaces/1 page' do
      response = get('/spaces/1')

      expect(response.status).to eq(200)
      expect(response.body).to include('Charming and cosy with a quirky front door')
    end
  end

  context 'GET /spaces' do
    it 'should get the spaces page' do
      response = get('/spaces')

      expect(response.status).to eq(200)
      expect(response.body).to include('Bag End')
      expect(response.body).to include('quirky front door')
    end
  end

  context 'GET-POST /login' do
    it 'displays login page' do
      response = get('/login')

      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Enter your login details</h1>')
    end

    it 'post the users input in the form and redirects to spaces' do
      response = post(
        '/login', 
      email: 'amber@example.com', 
      password: 'Password1' 
      )

      expect(response.status).to eq(302)
      # requires /spaces HTML code to expect (response.body)
    end
  end

  context "GET /logout" do
    it "redirects the user to the spaces page without any logged in functionality" do
      post '/login', params = { email: 'amber@example.com', password: 'Password1'}
      get '/logout'

      # Expect the response to have a 302 status code (redirect)
      expect(last_response.status).to eq(302)
      # Follow the redirect to the spaces page
      follow_redirect!

      expect(last_response.status).to eq(200)
      expect(last_response.body).to include('<p>Charming and cosy with a quirky front door</p>')
      expect(last_response.body).to include('<p>£70.0</p>')
    end
  end
end
