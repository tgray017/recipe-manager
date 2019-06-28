class UsersController < ApplicationController
  
  
  
  get '/login' do
    erb :"users/login"
  end
  
  post '/login' do
    user = User.find_by(:username => params[:username])
    if !!user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/recipes'
    else
      #set a flash message
      redirect to '/login'
    end
  end
  
  
  
  
end