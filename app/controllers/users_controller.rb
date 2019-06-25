class UsersController < ApplicationController
  
  get '/login' do
    erb :"users/login"
  end
  
  post '/login' do
    user = User.find_by("username" => params["username"])
    if user.authenticate(params["password"])
      redirect to '/recipes'
    else
      #set a flash message
      redirect to '/login'
    end
  end
end