class CreateRecipesAndIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :name
      t.integer :creator_id
      t.string :directions
      t.string :total_prep_time
    end
    
    create_table :ingredients do |t|
      t.string :name
    end
    
    create_table :ingredients_recipes, id: false do |t|
      t.belongs_to :recipe, index: true
      t.belongs_to :ingredient, index: true
    end
  end
end
