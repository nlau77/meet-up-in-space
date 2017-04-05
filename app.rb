require 'sinatra'
require_relative 'config/application'
require 'pry'

set :bind, '0.0.0.0'  # bind to all interfaces

helpers do
  def current_user
    if @current_user.nil? && session[:user_id]
      @current_user = User.find_by(id: session[:user_id])
      session[:user_id] = nil unless @current_user
    end
    @current_user
  end
end

get '/' do
  redirect '/meetups'
end

get '/auth/github/callback' do
  user = User.find_or_create_from_omniauth(env['omniauth.auth'])
  session[:user_id] = user.id
  flash[:notice] = "You're now signed in as #{user.username}!"

  redirect '/'
end

get '/sign_out' do
  session[:user_id] = nil
  flash[:notice] = "You have been signed out."

  redirect '/'
end

get '/meetups' do
  @meetups = Meetup.all.sort_by {|meetup| meetup.name}

  erb :'meetups/index'
end

get '/meetups/:id' do
  meetup_id = params["id"]
  @meetup = Meetup.find_by(id: meetup_id)
  user_id= @meetup.owner_id
  @username= User.find_by(id: user_id)

  erb :'meetups/show'
end

get '/new_meetup' do
  if current_user.nil?
    flash[:notice] = "You must be signed in to create a new meetup."
    redirect "/"
  end
  erb :'meetups/new'
end

post '/new_meetup' do
  meetup_name = params["meetup_name"]
  meetup_location = params["meetup_location"]
  meetup_description = params["meetup_description"]
  user_id = current_user.id
  details = {owner_id: user_id,
    name: meetup_name,
    description: meetup_description,
    location: meetup_location
  }
  new_meetup = Meetup.new(details)
  # if new_meetup.has_errors?
  #   flash[:errors] = new_meetup.error_message
  # else
  #   new_meetup.save
  # end
  new_meetup.save
  new_meetup_id = Meetup.last.id
  redirect "/meetups/#{new_meetup_id}"
end
