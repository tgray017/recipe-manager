class RecipesController < ApplicationController
  
  get '/recipes' do
    erb :"recipes/recipes"
  end
  
end