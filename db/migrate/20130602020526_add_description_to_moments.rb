class AddDescriptionToMoments < ActiveRecord::Migration
  def change
    add_column :moments, :description, :text
  end
end
