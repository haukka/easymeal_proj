# -*- encoding : utf-8 -*-
class AddPhotoToUser < ActiveRecord::Migration
  def change
    add_attachment :users, :photo
  end
end
