class AddNormalizedLocationToTheMoment < ActiveRecord::Migration
  def change
    change_table :moments do |t|
      t.point :coordinates, geographic: true, null: false
      t.index :coordinates, spatial: true
    end
  end
end
