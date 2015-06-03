class AddValidatedToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :validated, :boolean, default: false
  end
end
