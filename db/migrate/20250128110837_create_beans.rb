class CreateBeans < ActiveRecord::Migration[7.1]
  def change
    create_table :beans do |t|
      t.string :name
      t.text :description
      t.string :image
      t.string :roast_level
      t.string :brewing_method
      t.references :user, null: false, foreign_key: true
      t.references :roastery, null: false, foreign_key: true

      t.timestamps
    end
  end
end
