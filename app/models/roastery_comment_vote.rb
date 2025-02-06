class RoasteryCommentVote < ApplicationRecord
  belongs_to :user
  belongs_to :roastery_comment

  validates :user_id, uniqueness: { scope: :roastery_comment_id, message: "You have already liked this comment" }
end
