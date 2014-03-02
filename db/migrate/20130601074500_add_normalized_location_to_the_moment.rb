class AddNormalizedLocationToTheMoment < ActiveRecord::Migration
  def change
    enable_extension "postgis"
    change_table :moments do |t|
      t.point :coordinates, geographic: true, null: false
      t.index :coordinates, spatial: true
    end
  end
end
