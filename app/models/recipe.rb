class Recipe < ActiveRecord::Base
  belongs_to :creator, :class_name => "User"
  alias_attribute :user_id, :creator_id
  has_many :ingredients_recipes
  has_many :ingredients, through: :ingredients_recipes
end