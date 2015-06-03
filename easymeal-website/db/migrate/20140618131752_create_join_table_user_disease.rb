# -*- encoding : utf-8 -*-
class CreateJoinTableUserDisease < ActiveRecord::Migration
  def change
    create_join_table :users, :diseases do |t|
      # t.index [:user_id, :disease_id]
      # t.index [:disease_id, :user_id]
    end
  end
end
