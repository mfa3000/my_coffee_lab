class CreateRoasteryReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :roastery_reviews do |t|
      t.integer :rating
      t.references :roastery, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
