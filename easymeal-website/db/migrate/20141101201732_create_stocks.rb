# -*- encoding : utf-8 -*-
class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.integer :home_id

      t.timestamps
    end
  end
end
