class AddWorkflowToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :workflow_state, :string
  end
end
