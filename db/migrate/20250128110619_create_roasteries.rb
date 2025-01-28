class CreateRoasteries < ActiveRecord::Migration[7.1]
  def change
    create_table :roasteries do |t|
      t.string :name
      t.text :description
      t.string :image
      t.string :address
      t.string :roastery_url
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
