# -*- encoding : utf-8 -*-
class CreateAllergenAndFavoriteAliments < ActiveRecord::Migration
  def change
    create_table :allergen_and_favorite_aliments do |t|
      t.integer :users
      t.integer :aliment_id
      t.boolean :allergy

      t.timestamps
    end
  end
end
