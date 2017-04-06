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
  @meetup_id = meetup_id
  erb :'meetups/show'
end

post '/meetups/:id' do
  meetup_id = params[:id].to_i
  if current_user
    user_id = current_user.id
    MeetupsUser.create(meetup_id: meetup_id, user_id: user_id)
    flash[:notice] = "You have joined the #{Meetup.find_by(id: meetup_id).name}! Yay"
    redirect "/meetups/#{meetup_id}"
  else
    flash[:notice] = "You need to be logged in to join #{Meetup.find_by(id: meetup_id).name}!"
    redirect "/meetups/#{meetup_id}"
  end
end

get '/new_meetup' do
  if current_user.nil?
    flash[:notice] = "You must be signed in to create a new meetup."
    redirect "/"
  end
  @post_info = {}
  erb :'meetups/new'
end

post '/new_meetup' do
  meetup_name = params["meetup_name"]
  meetup_location = params["meetup_location"]
  meetup_description = params["meetup_description"]
  user = current_user
  details = {owner: user,
    name: meetup_name,
    description: meetup_description,
    location: meetup_location
  }
  new_meetup = Meetup.new(details)
  new_meetup.save
    if new_meetup.errors.messages.empty?
      new_meetup_id = Meetup.last.id
      redirect "/meetups/#{new_meetup_id}"
    else
      @errors= new_meetup.errors
      @post_info = params
      erb :'meetups/new'
    end
end

get '/user/:username' do
  username = params["username"]
  @created_meetups = User.find_by(username: username).creations
  @joined_meetups = User.find_by(username: username).meetups
  erb :'meetups/userpage'
end


post '/edit' do
  meetup_id= params["meetup_id"].to_i
  @meetup= Meetup.find_by(id: meetup_id)
  erb :'meetups/edit'

end

post '/edit_meetup' do
  meetup_name = params["meetup_name"]
  meetup_location = params["meetup_location"]
  meetup_description = params["meetup_description"]
  meetup_id = params["meetup_id"].to_i
  user = current_user

  update_meetup = Meetup.find_by(id: meetup_id)
  update_meetup.update_attributes(:name => meetup_name, :description => meetup_description, :location => meetup_location)
    if update_meetup.errors.messages.empty?

      redirect "/meetups/#{meetup_id}"
    else
      @errors= update_meetup.errors
      @post_info = params
      erb :'meetups/new'
    end

end

post '/delete' do

  meetup_id = params["meetup_id"].to_i
  MeetupsUser.where(meetup_id: meetup_id).destroy_all
  Meetup.find(meetup_id).destroy
  flash[:notice] = "You have deleted the event!"

  redirect '/'
end
