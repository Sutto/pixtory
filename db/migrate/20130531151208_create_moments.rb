class CreateMoments < ActiveRecord::Migration
  def change
    create_table :moments do |t|
      t.string  :image, null: false
      t.integer :width
      t.integer :height
      t.text :caption, null: false
      t.text :location, null: false
      t.date :captured_at
      t.boolean :approximate_date, default: false
      t.text :source_url
      t.string :source_name
      t.string :license
      t.timestamps
    end
  end
end
