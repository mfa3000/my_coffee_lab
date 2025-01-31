class CreateLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :locations do |t|
      t.string :address
      t.string :location_type
      t.string :type
      t.float :latitude
      t.float :longitude
      t.references :roastery, null: false, foreign_key: true

      t.timestamps
    end
  end
end
