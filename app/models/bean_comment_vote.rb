class BeanCommentVote < ApplicationRecord
  belongs_to :bean_comment
  belongs_to :user
  validates :user_id, uniqueness: { scope: :bean_comment_id, message: "You have already liked this comment" }
end
