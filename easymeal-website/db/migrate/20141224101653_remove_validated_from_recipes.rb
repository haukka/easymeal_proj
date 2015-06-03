class RemoveValidatedFromRecipes < ActiveRecord::Migration
  def change
    remove_column :recipes, :validated, :boolean
  end
end
