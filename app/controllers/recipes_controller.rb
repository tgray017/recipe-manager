class RecipesController < ApplicationController
  
  get '/recipes' do
    @user = User.current_user(session) if User.logged_in?(session)
    erb :"recipes/index"
  end
  
  get '/recipes/new' do
    if User.logged_in?(session)
      erb :"recipes/new"
    else
      redirect to '/login'
    end
  end
  
  get '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    @user = User.current_user(session) if User.logged_in?(session)
    
    if !!@recipe
      erb :"recipes/show"
    else
      #set a flash message - recipe doesn't exist
      flash[:recipe_does_not_exist] = "That recipe does not exist, try again!"
      #binding.pry
      redirect to '/recipes'
    end
  end
  
  post '/recipes' do
    if User.logged_in?(session)
      if invalid_recipe?
        #set flash message - make sure your recipe has a name, directions, total prep time, and at least one ingredient with a quantity
        redirect to '/recipes/new'
      else
        recipe = Recipe.create(:name => params[:recipe][:name], :creator => User.current_user(session), :directions => params[:recipe][:directions], :total_prep_time => params[:recipe][:total_prep_time])
        params[:recipe][:ingredients_attributes].each do |i|
          recipe.ingredients.create(:name => i[:name], :quantity => i[:quantity], :unit => i[:unit]) unless empty_ingredient?(i)
        end
        redirect to "/recipes/#{recipe.id}"
      end
    else
      redirect to '/login'
    end
  end
  
  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by_id(params[:id])
    
    if User.logged_in?(session)
      if !!@recipe && User.current_user(session).recipes.include?(@recipe)
        erb :"recipes/edit"
      else
        #set flash message - recipe does not exist or does not belong to you
        redirect to '/recipes'
      end
    else
      redirect to '/login'
    end
  end
    
  patch '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    
    if User.logged_in?(session)
      if !!@recipe && User.current_user(session).recipes.include?(@recipe)
        if invalid_recipe?
          #set flash message - make sure your recipe has a name, directions, total prep time, and at least one ingredient with a quantity
          redirect to "/recipes/#{@recipe.id}/edit"
        else
          @recipe.update(params[:recipe])
          redirect to "/recipes/#{@recipe.id}"
        end
      else
        #set flash message - recipe does not exist or does not belong to you
        redirect to '/recipes'
      end
    else
      redirect to '/login'
    end
  end
  
  delete '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    
    if User.logged_in?(session)
      if !!@recipe && User.current_user(session).recipes.include?(@recipe)
        @recipe.destroy
        redirect to "/recipes"
      else
        #set flash message - recipe does not exist or does not belong to you
        redirect to "/recipes/#{@recipe.id}"
      end
    else
      redirect to '/login'
    end
  end
  
  
  ##### Helper methods #####
  
  def invalid_recipe?
    invalid_ingredients? || params[:recipe][:name].empty? ||  params[:recipe][:directions].empty? ||  params[:recipe][:total_prep_time].empty?
  end
  
  def invalid_ingredients?
    params[:recipe][:ingredients_attributes].any? {|i| !empty_ingredient?(i) && (i[:name].empty? || i[:quantity].empty?)} || params[:recipe][:ingredients_attributes].all? {|i| i[:name].empty?}
  end
  
  def empty_ingredient?(ingredient)
    ingredient.values.all? {|v| v.empty?}
  end
  

end