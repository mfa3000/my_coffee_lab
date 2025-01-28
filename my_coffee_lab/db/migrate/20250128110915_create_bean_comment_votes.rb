class CreateBeanCommentVotes < ActiveRecord::Migration[7.1]
  def change
    create_table :bean_comment_votes do |t|
      t.boolean :vote
      t.references :bean_comment, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
