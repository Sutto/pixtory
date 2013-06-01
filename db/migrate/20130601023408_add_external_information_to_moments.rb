class AddExternalInformationToMoments < ActiveRecord::Migration
  def change
    change_table :moments do |t|
      t.string :external_key
      t.string :external_identifier
    end
    add_index :moments, [:external_key, :external_identifier], unique: true
  end
end
