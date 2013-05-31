class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :avatar
      t.string :location
      t.string :push_token,           null: false
      t.string :authentication_token, null: false
      t.timestamps
    end
    add_index :people, [:push_token],           unique: true
    add_index :people, [:authentication_token], unique: true
  end
end
