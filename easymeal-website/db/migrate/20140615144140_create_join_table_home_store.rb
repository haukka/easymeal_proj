# -*- encoding : utf-8 -*-
class CreateJoinTableHomeStore < ActiveRecord::Migration
  def change
    create_join_table :homes, :stores do |t|
      # t.index [:home_id, :store_id]
      # t.index [:store_id, :home_id]
    end
  end
end
