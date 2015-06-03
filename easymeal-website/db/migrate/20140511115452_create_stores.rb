# -*- encoding : utf-8 -*-
class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.string :country

      t.timestamps
    end
  end
end
