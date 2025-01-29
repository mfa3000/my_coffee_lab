class AddLatitudeAndLongitudeToRoasteries < ActiveRecord::Migration[7.1]
  def change
    add_column :roasteries, :latitude, :float
    add_column :roasteries, :longitude, :float
  end
end
