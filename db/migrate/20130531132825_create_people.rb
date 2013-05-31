class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :avatar
      t.string :location
      t.string :push_token
      t.string :authentication_token

      t.timestamps
    end
  end
end
