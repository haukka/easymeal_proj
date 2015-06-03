# -*- encoding : utf-8 -*-
class AddShoppingListsToAlimentsQuantity < ActiveRecord::Migration
  def change
    add_column :aliments_quantities, :shopping_list_id, :integer
  end
end
