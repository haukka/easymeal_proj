# -*- encoding : utf-8 -*-
class CreateJoinTableAlimentHome < ActiveRecord::Migration
  def change
    create_join_table :aliments, :homes do |t|
      # t.index [:aliment_id, :home_id]
      # t.index [:home_id, :aliment_id]
    end
  end
end
