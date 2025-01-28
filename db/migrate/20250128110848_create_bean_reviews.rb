class CreateBeanReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :bean_reviews do |t|
      t.integer :rating
      t.references :user, null: false, foreign_key: true
      t.references :bean, null: false, foreign_key: true

      t.timestamps
    end
  end
end
