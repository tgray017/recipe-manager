class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :name
      t.integer :creator_id
      t.string :directions
      t.string :total_prep_time
    end
  end
end
