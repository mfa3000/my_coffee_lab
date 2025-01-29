class AddFiltersToBeans < ActiveRecord::Migration[7.1]
  def change
    add_column :beans, :origin, :string
    add_column :beans, :flavour, :string
  end
end
