class IngredientsRecipe < ActiveRecord::Base
  belongs_to :ingredient
  belongs_to :recipe
  has_one :unit

def self.find_quantity(recipe, ingredient)
  query = <--SQL
    select ir.quantity
    from
      ingredients_recipes ir
      join ingredients i on ir.ingredient_id = i.id
      join recipes r on ir.recipe_id = r.id
    where
      r.name = ?
      and i.name = ?
  SQL
  
  execute_sql(query, recipe.name, ingredient.name)
end

end



