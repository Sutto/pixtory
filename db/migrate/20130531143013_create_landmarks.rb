class CreateLandmarks < ActiveRecord::Migration
  def change
    create_table :landmarks do |t|
      t.string :location, null: false
      t.string :city
      t.string :suburb
      t.string :street
      t.point :coordinates, geographic: true, null: false
      t.timestamps
    end
    add_index :landmarks, :coordinates, spatial: true
  end
end
