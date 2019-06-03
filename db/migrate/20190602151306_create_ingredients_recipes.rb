class CreateIngredientsRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredients_recipes do |t|
      t.belongs_to :recipe, index: true
      t.belongs_to :ingredient, index: true
      t.integer :quantity
      t.integer :unit_id
    end
  end
end
