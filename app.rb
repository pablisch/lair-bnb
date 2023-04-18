require 'sinatra/base'
require 'sinatra/reloader'

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    return erb(:index)
  end

  get '/spaces' do
    return erb(:spaces)
  end

  get '/spaces/:id' do
    repo = SpaceRepository.new
    space = repo.find_by_id(params[:id])
  end
end