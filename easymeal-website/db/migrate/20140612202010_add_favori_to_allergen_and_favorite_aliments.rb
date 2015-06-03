class AddFavoriToAllergenAndFavoriteAliments < ActiveRecord::Migration
  def up
    add_column :allergen_and_favorite_aliments, :favori, :boolean
  end

  def down
    remove_column :allergen_and_favorite_aliments, :favori
  end
end
