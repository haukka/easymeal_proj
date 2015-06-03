class AddNameToShoppingLists < ActiveRecord::Migration
  def change
    add_column :shopping_lists, :name, :string
  end
end
