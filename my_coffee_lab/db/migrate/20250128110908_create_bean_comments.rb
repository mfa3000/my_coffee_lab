class CreateBeanComments < ActiveRecord::Migration[7.1]
  def change
    create_table :bean_comments do |t|
      t.text :comment
      t.references :user, null: false, foreign_key: true
      t.references :bean, null: false, foreign_key: true

      t.timestamps
    end
  end
end
