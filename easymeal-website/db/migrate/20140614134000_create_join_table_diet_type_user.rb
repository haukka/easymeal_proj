# -*- encoding : utf-8 -*-
class CreateJoinTableDietTypeUser < ActiveRecord::Migration
  def change
    create_join_table :diet_types, :users do |t|
      # t.index [:diet_type_id, :user_id]
      # t.index [:user_id, :diet_type_id]
    end
  end
end
