class Recipe < ActiveRecord::Base
  belongs_to :creator, :class_name => "User"
  alias_attribute :user_id, :creator_id
  has_many :ingredients_recipes
  has_many :ingredients, through: :ingredients_recipes
  accepts_nested_attributes_for :ingredients
  
  
  # need to override this method provided by accepts_nested_attributes_for to avoid duplicating ingredients and creating empty ingredients
  
  def ingredients_attributes=(ingredients_attributes)
    self.ingredients.destroy_all
    ingredients_attributes.each do |ingredient_attribute|
      # additional logic in the recipes controller rejects invalid ingredients
    
      self.ingredients.create(ingredient_attribute) unless all_blank?(ingredient_attribute)
    end
  end
  
  def all_blank?(ingredient_attribute)
    ingredient_attribute.all? {|k, v| v.blank?}
  end
  
end