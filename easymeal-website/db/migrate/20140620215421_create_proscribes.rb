# -*- encoding : utf-8 -*-
class CreateProscribes < ActiveRecord::Migration
  def change
    create_table :proscribes do |t|
      t.integer :disease_id
      t.integer :aliment_id

      t.timestamps
    end
  end
end
