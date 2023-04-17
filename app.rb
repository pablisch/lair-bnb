require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/user_repo'
require_relative 'lib/database_connection'

DatabaseConnection.connect('makersbnb')

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    return erb(:index)
  end

  get '/login' do
    return erb(:login)
  end

  post '/login' do
    email = params[:email]
    password = params[:password]

    repo = UserRepository.new
    user = repo.find_by_email(email)

    if user && email == user.email && password == user.password
      session[:email] = user.email

      return erb(:index) # need to change to spaces later
    else
      return erb(:index)
    end
  end
end