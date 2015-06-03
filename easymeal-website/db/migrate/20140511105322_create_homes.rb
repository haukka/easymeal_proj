class CreateHomes < ActiveRecord::Migration
  def change
    create_table :homes do |t|
      t.string :street
      t.string :city
      t.integer :householder

      t.timestamps
    end
  end
end
