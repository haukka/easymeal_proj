class CreateRecipeCategoriesRecipes < ActiveRecord::Migration
  def change
    create_join_table :recipe_categories, :recipes do |t|
    end
  end
end
