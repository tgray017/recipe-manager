class Recipe < ActiveRecord::Base
  belongs_to :creator, :class_name => "User"
  alias_attribute :user_id, :creator_id
  has_many :ingredients_recipes
  has_many :ingredients, through: :ingredients_recipes
  accepts_nested_attributes_for :ingredients
  
  def ingredients_attributes=(ingredients_attributes)
    self.ingredients.destroy_all
    self.ingredients.create(ingredients_attributes)
  end
end