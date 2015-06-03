class CreateModerates < ActiveRecord::Migration
  def change
    create_table :moderates do |t|
      t.integer :disease_id
      t.integer :aliment_id

      t.timestamps
    end
  end
end
