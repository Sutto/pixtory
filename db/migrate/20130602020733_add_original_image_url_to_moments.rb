class AddOriginalImageUrlToMoments < ActiveRecord::Migration
  def change
    add_column :moments, :source_image_url, :text
  end
end
