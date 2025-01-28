class CreateFavouriteRoasteries < ActiveRecord::Migration[7.1]
  def change
    create_table :favourite_roasteries do |t|
      t.references :roastery, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
