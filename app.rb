require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/space_repo'
require_relative 'lib/user_repo'
require_relative 'lib/database_connection'

DatabaseConnection.connect('makersbnb') unless ENV['ENV'] == 'test'

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions

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
      return "Login Failed"
      # need to add redirect to index later
    end
  end

  get '/logout' do
    session.clear
    redirect ('/spaces')
  end

  get '/spaces' do
    repo = SpaceRepository.new
    @spaces = repo.all()

    return erb(:spaces)
  end

  get '/spaces/:id' do
    repo = SpaceRepository.new
    @space = repo.find_by_id(params[:id])
    return erb(:spaces_id)
  end
end