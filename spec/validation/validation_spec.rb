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

  context 'checking the inputs for strings' do
    it 'responds with 302 status if parameters are invalid' do
        response = post(
            '/login',
            email: '',
            password: ''
        )
        expect(response.status).to eq(302)
        response = get('/login')
        expect(response.body).to include "Please fill in all required fields."
    end
  end

  context 'checking the inputs on post /' do
    it 'responds with 302 status if parameters are invalid' do
        response = post(
            '/',
            available_from: '',
            available_to: ''
        )
        expect(response.status).to eq(302)
    end
  end
  
  context 'password strength requirements' do
    it 'responds 302 if length not greater than 8' do
        response = post(
            '/login',
            email: 'amber@example.com',
            password: 'aaaa'
        )
        expect(response.status).to eq(302)
        response = get('/login')
        expect(response.body).to include "Contact support to strengthen your password."
    end
  end

  context 'login must contain an @ symbol' do
    it 'should be false if @ included' do
        response = post(
            '/login',
            email: 'amberexample.com',
            password: 'Password1'
        )
        expect(response.status).to eq(302)
        response = get('/login')
        expect(response.body).to include "Please enter a valid email address."
    end
  end
  
  #Validation check not needed anymore for login, could be used elsewhere so leaving for reference.
  context 'login must not contain forbidden char' do
    it 'should be true because email contains ";"' do
        response = post(
            '/login',
            email: ";amber@example.com",
            password: "Password1"
        )
        expect(response.status).to eq(302)
        response = get('/login')
        expect(response.body).to include "You have entered a special character. Try again."
    end
  end

  context 'login should work as inputs are correct' do
    it 'should be true because formatted correctly' do
      response = post(
          '/login',
          email: 'amber@example.com',
          password: 'Password1'
      )
      expect(response.status).to eq(302)
      response = get('/')
      expect(response.body).to include "Amber"
    end
  end
end