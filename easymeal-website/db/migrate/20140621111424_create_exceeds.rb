# -*- encoding : utf-8 -*-
class CreateExceeds < ActiveRecord::Migration
  def change
    create_table :exceeds do |t|
      t.integer :disease_id
      t.integer :aliment_id

      t.timestamps
    end
  end
end
