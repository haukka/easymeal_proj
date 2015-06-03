class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :firstname
      t.string :lastname
      t.string :password
      t.string :gender
      t.date :birth
      t.string :mail
      t.integer :role
      t.date :lastConnexion
      t.integer :loginAttempts
      t.date :lock
      t.boolean :islock
      t.string :resetToken
      t.boolean :highCholesterol
      t.boolean :highBloodPressure
      t.integer :height
      t.integer :weight
      t.integer :desireWeight
      t.integer :idealWeight
      t.integer :homeId
      t.integer :weightPointId
      t.integer :dietTypeId
      t.integer :weightCurveId

      t.timestamps
    end
  end
end
