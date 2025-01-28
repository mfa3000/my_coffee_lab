class CreateRoasteryCommentVotes < ActiveRecord::Migration[7.1]
  def change
    create_table :roastery_comment_votes do |t|
      t.boolean :vote
      t.references :user, null: false, foreign_key: true
      t.references :roastery_comment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
