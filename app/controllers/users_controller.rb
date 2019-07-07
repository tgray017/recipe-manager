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
      #set a flash message - user already exists - please go to our login page if you already have an account
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
    if invalid_login?
      #set a flash message - please fill out all fields
      redirect to '/login'
    else
      user = User.find_by(:username => params[:username])
      if !!user && !!user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect to '/recipes'
      else
        #set a flash message - wrong password username combo 
        redirect to '/login'
      end
    end
  end
  
  get '/logout' do
    session.clear
    redirect to '/login'
  end
  
  get '/users/:id' do
    @user = User.find(params[:id])
    erb :"users/show"
  end
  
  
  #### Helper methods ####
  
  def invalid_signup?
    params[:email].empty? || params[:username].empty? || params[:password].empty?
  end
  
  def invalid_login?
    params[:username].empty? || params[:password].empty?
  end
  
  
end