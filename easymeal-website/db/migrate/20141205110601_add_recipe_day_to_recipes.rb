class AddRecipeDayToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :recipe_day, :boolean, default: false
  end
end
