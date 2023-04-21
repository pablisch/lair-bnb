require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/space_repo'
require_relative 'lib/user_repo'
require_relative 'lib/database_connection'
require 'sinatra/flash'
require_relative 'lib/validation'
require_relative 'lib/booking_repo'

DatabaseConnection.connect('makersbnb') unless ENV['ENV'] == 'test'

class Application < Sinatra::Base
  include Validation
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

  post '/' do
    return redirect('/') if validation_nil_empty_input(params) 

    available_from = params[:available_from]
    available_to = params[:available_to]
    
    repo = SpaceRepository.new
    @spaces = repo.get_available_dates_filter(available_from, available_to)
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
      session[:username] = user.username
      session[:id] = user.id

    elsif validation_nil_empty_input(params) || 
        validation_no_asperand(params[:email]) || 
          validation_length_of_sting(params[:password]) || 
            validation_forbidden_char(params)
      status 400
      return ''
    else
      flash[:login_error] = "Username or Password not recognised"
      return redirect('/login')
    end
    return redirect('/')
  end

  get '/logout' do
    session.clear
    redirect ('/')
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
    session[:space_id] = params[:id]
    @space = repo.find_by_id(params[:id])
    @available_dates = repo.get_available_dates(params[:id])
    return erb(:spaces_id)
  end

  post '/spaces/:id' do

    redirect '/login' if session[:id] == nil

    booking_repo = BookingRepository.new
    space_repo = SpaceRepository.new
    user_repo = UserRepository.new

    booking = Booking.new
    booking.booking_date = params[:booking_date]
    booking.status = params[:status]
    booking.space_id = session[:space_id].to_i
    booking.guest_id = session[:id].to_i
    booking_repo.create(booking)

    if booking_repo.create(booking)
      flash[:success] = "Your booking has been submitted!"
    end
    redirect "/spaces/#{session[:space_id]}"
  end

  get '/bookings_by_me' do
    repo = BookingRepository.new
    spaces_repo = SpaceRepository.new
    @confirmed_bookings = repo.bookings_by_me('confirmed', session[:id])
    @pending_bookings = repo.bookings_by_me('pending', session[:id])
    @denied_bookings = repo.bookings_by_me('denied', session[:id])

    return erb(:bookings_by_me)
  end
end
