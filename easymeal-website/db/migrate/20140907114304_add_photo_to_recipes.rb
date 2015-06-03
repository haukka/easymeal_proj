# -*- encoding : utf-8 -*-
class AddPhotoToRecipes < ActiveRecord::Migration
  def change
    add_attachment :recipes, :photo
  end
end
