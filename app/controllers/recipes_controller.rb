class RecipesController < ApplicationController
  
  get '/recipes' do
    if User.logged_in?(session)
      erb :"recipes/index"
    else
      redirect to '/login'
    end
  end
  
  get '/recipes/:id' do
    if User.logged_in?(session)
      if !!Recipe.find(params[:id])
        recipe = Recipe.find(params[:id])
        erb :"recipes/show"
      else
        #set a flash message - recipe doesn't exist
        redirect to '/recipes'
      end
    else
      redirect to '/login'
    end
  end
  
end