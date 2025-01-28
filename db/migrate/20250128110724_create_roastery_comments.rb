class CreateRoasteryComments < ActiveRecord::Migration[7.1]
  def change
    create_table :roastery_comments do |t|
      t.text :comment
      t.references :roastery, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
