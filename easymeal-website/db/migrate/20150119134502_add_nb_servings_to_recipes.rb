class AddNbServingsToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :nb_servings, :integer, default: 1
  end
end
