class RemoveAddressFromRoasteries < ActiveRecord::Migration[7.1]
  def change
    remove_column :roasteries, :address, :string
  end
end
