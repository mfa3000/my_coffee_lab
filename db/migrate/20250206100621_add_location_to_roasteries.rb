class AddLocationToRoasteries < ActiveRecord::Migration[7.1]
  def change
    add_column :roasteries, :location, :string
  end
end
