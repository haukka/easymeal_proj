# -*- encoding : utf-8 -*-
class CreateShoppingLists < ActiveRecord::Migration
  def change
    create_table :shopping_lists do |t|
      t.float :totalPrice
      t.integer :home_id

      t.timestamps
    end
  end
end
