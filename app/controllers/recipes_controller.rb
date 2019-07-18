class RecipesController < ApplicationController

  get '/recipes' do
    erb :"recipes/index"
  end

  get '/recipes/new' do
    redirect_if_not_logged_in
    erb :"recipes/new"
  end

  get '/recipes/:id' do
    if !!current_recipe
      erb :"recipes/show"
    else
      flash[:alert] = "That recipe does not exist, try selecting a different recipe."
      redirect to '/recipes'
    end
  end

  post '/recipes' do
    redirect_if_not_logged_in
    if invalid_recipe?
      flash[:alert] = "Invalid recipe! Make sure your recipe has a name, directions, total prep time, and at least one ingredient with a quantity."
      redirect to '/recipes/new'
    else
      recipe = Recipe.create(:name => params[:recipe][:name], :creator => User.current_user(session), :directions => params[:recipe][:directions], :total_prep_time => params[:recipe][:total_prep_time])
      params[:recipe][:ingredients_attributes].each do |i|
        recipe.ingredients.create(:name => i[:name], :quantity => i[:quantity], :unit => i[:unit]) unless empty_ingredient?(i)
      end
      redirect to "/recipes/#{recipe.id}"
    end
  end

  get '/recipes/:id/edit' do
    redirect_if_not_logged_in
    if !!current_recipe && current_user.recipes.include?(current_recipe)
      erb :"recipes/edit"
    else
      flash[:alert] = "You cannot edit this recipe."
      redirect to '/recipes'
    end
  end

  patch '/recipes/:id' do
    redirect_if_not_logged_in
    if !!current_recipe && current_user.recipes.include?(current_recipe)
      if invalid_recipe?
        flash[:alert] = "Invalid recipe! Make sure your recipe has a name, directions, total prep time, and at least one ingredient with a quantity."
        redirect to "/recipes/#{current_recipe.id}/edit"
      else
        current_recipe.update(params[:recipe])
        redirect to "/recipes/#{current_recipe.id}"
      end
    else
      flash[:alert] = "You cannot edit this recipe."
      redirect to '/recipes'
    end
  end

  delete '/recipes/:id' do
    redirect_if_not_logged_in
    if !!current_recipe && current_user.recipes.include?(current_recipe)
      current_recipe.destroy
      redirect to "/recipes"
    else
      flash[:alert] = "You cannot edit this recipe."
      redirect to "/recipes/#{current_recipe.id}"
    end
  end


  helpers do
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


end
