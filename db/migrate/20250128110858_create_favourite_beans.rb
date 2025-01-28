class CreateFavouriteBeans < ActiveRecord::Migration[7.1]
  def change
    create_table :favourite_beans do |t|
      t.references :bean, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
