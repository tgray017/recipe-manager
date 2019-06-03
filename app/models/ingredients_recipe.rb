class IngredientsRecipe < ActiveRecord::Base
  belongs_to :ingredient
  belongs_to :recipe
  has_one :unit

def self.find_quantity(recipe, ingredient)
  
  
end

end



