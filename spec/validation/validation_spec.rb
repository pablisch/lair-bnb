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
    it 'responds with 400 status if parameters are invalid' do
        response = post(
            '/login',
            email: '',
            password: ''
        )
        expect(response.status).to eq(400)
    end
  end

  context 'checking the inputs on post /' do
    it 'responds with 400 status if parameters are invalid' do
        response = post(
            '/',
            available_from: '',
            available_to: ''
        )
        expect(response.status).to eq(302)
    end
  end
  
  context 'password strength requirements' do
    it 'responds 400 if length not greater than 8' do
        response = post(
            '/login',
            email: 'amber@example.com',
            password: 'aaaa'
        )
        expect(response.status).to eq(400)
    end
  end

  context 'login must contain an @ symbol' do
    it 'should be false if @ included' do
        response = post(
            '/login',
            email: 'amberexample.com',
            password: 'Password1'
        )
        expect(response.status).to eq(400)
    end
  end
  
  context 'login must not contain forbidden char' do
    it 'should be false because email contains <>' do
        response = post(
            '/login',
            email: '<amberexample.com>',
            password: 'Password1'
        )
        expect(response.status).to eq(400)
    end

    it 'should be true because formatted correctly' do
      response = post(
          '/login',
          email: 'amber@example.com',
          password: 'Password1'
      )
      expect(response.status).to eq(302)
    end
  end
end