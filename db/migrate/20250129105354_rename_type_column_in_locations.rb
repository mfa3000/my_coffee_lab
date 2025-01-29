class RenameTypeColumnInLocations < ActiveRecord::Migration[7.1]
  def change
    rename_column :locations, :type, :location_type
  end
end
