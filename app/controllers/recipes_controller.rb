class RecipesController < ApplicationController
  
  get '/recipes' do
    if User.logged_in?(session)
      erb :"recipes/index"
    else
      redirect to '/login'
    end
  end
  
  get '/recipes/new' do
    erb :"recipes/new"  
  end
  
  get '/recipes/:id' do
    if User.logged_in?(session)
      if !!Recipe.find(params[:id])
        @recipe = Recipe.find(params[:id])
        erb :"recipes/show"
      else
        #set a flash message - recipe doesn't exist
        redirect to '/recipes'
      end
    else
      redirect to '/login'
    end
  end
  
  post '/recipes' do

    recipe = Recipe.create(:name => params[:recipe][:name], :creator => User.current_user(session), :directions => params[:recipe][:directions], :total_prep_time => params[:recipe][:total_prep_time])
    params[:recipe][:ingredients].each do |i|
      binding.pry
      ingredient = Ingredient.create(:name => i[:name], :quantity => i[:quantity], :unit => i[:unit])
    end
    binding.pry
  end
  

  
  
end