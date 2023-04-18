require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/space_repo'
require_relative 'lib/user_repo'
require_relative 'lib/database_connection'
require 'sinatra/flash'

DatabaseConnection.connect('makersbnb') unless ENV['ENV'] == 'test'

class Application < Sinatra::Base
  enable :sessions
  
  configure :development do
    register Sinatra::Reloader
    register Sinatra::Flash
    enable :sessions
  end

  get '/' do
    repo = SpaceRepository.new
    if session[:email].nil?
      @spaces = repo.all()
    else
      @spaces = repo.all_except_owner(session[:id])
    end

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
      session[:id] = user.id
    end
    
    return redirect('/')
  end

  get '/logout' do
    session.clear
    redirect ('/')
  end

  get '/spaces' do
    repo = SpaceRepository.new
    if session[:email].nil?
      @spaces = repo.all()
    else
      @spaces = repo.all_except_owner(session[:id])
    end

    return erb(:spaces)
  end

  get '/new_space' do
    return erb(:new_space)
  end

  post '/new_space' do
    user_repo = UserRepository.new
    user = user_repo.find_by_email(session[:email])

    new_space = Space.new
    new_space.name = params[:name]
    new_space.description = params[:description]
    new_space.price = params[:price]
    new_space.available_from = params[:available_from]
    new_space.available_to = params[:available_to]
    new_space.user_id = user.id

    repo = SpaceRepository.new
    @space = repo.create(new_space)

    flash[:space_created] = "New Space Listed"
    redirect '/new_space'
  end

  get '/spaces/:id' do
    repo = SpaceRepository.new
    @space = repo.find_by_id(params[:id])
    return erb(:spaces_id)
  end
end
