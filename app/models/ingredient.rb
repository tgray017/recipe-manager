class Ingredient < ActiveRecord::Base
  has_many :ingredients_recipes
  has_many :recipes, through: :ingredients_recipes
  #has_many :quantities, through: :ingredients_recipes
  #has_many :units, through: :ingredients_recipes
end