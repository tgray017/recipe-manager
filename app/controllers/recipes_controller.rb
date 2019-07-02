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
    if invalid_recipe?
      #set flash message - make sure your recipe has a name, directions, total prep time, and at least one ingredient with a quantity
      redirect to '/recipes/new'
    else
      recipe = Recipe.create(:name => params[:recipe][:name], :creator => User.current_user(session), :directions => params[:recipe][:directions], :total_prep_time => params[:recipe][:total_prep_time])
      params[:recipe][:ingredients].each do |i|
        recipe.ingredients.create(:name => i[:name], :quantity => i[:quantity], :unit => i[:unit]) unless empty_ingredient?(i)
      end
    end
  end
  
  
  ##### Helper methods #####
  
  def invalid_recipe?
    invalid_ingredients? || params[:recipe][:name].empty? ||  params[:recipe][:directions].empty? ||  params[:recipe][:total_prep_time].empty?
  end
  
  def invalid_ingredients?
    params[:recipe][:ingredients].any? {|i| !empty_ingredient?(i) && (i[:name].empty? || i[:quantity].empty?)} || params[:recipe][:ingredients].all? {|i| i[:name].empty?}
  end
  
  def empty_ingredient?(ingredient)
    ingredient.values.all? {|v| v.empty?}
  end
  

  
  
end