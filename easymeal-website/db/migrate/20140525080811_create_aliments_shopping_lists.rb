# -*- encoding : utf-8 -*-
class CreateAlimentsShoppingLists < ActiveRecord::Migration
  def change
    create_table :aliments_shopping_lists do |t|
      t.belongs_to :aliments
      t.belongs_to :shopping_lists
    end
  end
end
