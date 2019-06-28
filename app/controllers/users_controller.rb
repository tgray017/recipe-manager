class UsersController < ApplicationController
  
  get '/signup' do
    if User.logged_in?(session)
      redirect to '/recipes'
    else
      erb :"users/signup"
    end
  end
  
  post '/signup' do
    if invalid_signup?
      #set a flash message - please fill out all fields
      redirect to '/signup'
    elsif !!User.find_by(:username => params[:username])
      #set a flash message - user already exists or not all fields are filled out
      redirect to '/signup'
    else
      user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
      session[:user_id] = user.id
      redirect to '/recipes'
    end
  end
  
  get '/login' do
    if User.logged_in?(session)
      redirect to '/recipes'
    else
      erb :"users/login"
    end
  end
  
  post '/login' do
    user = User.find_by(:username => params[:username])
    if !!user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/recipes'
    else
      #set a flash message - wrong password
      redirect to '/login'
    end
  end
  
  
  #### Helper methods ####
  
  def invalid_signup?
    params[:email].empty? || params[:username].empty? || params[:password].empty?
  end
  
  def invalid_login?
    params[:username].empty? || params[:password].empty?
  end
  
  
end