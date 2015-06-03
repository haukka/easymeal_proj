class RenameUsersToUserIdInAllergenAndFavoriteAlimentTable < ActiveRecord::Migration
  def change
    rename_column :allergen_and_favorite_aliments, :users, :user_id
  end
end
