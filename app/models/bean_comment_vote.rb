class BeanCommentVote < ApplicationRecord
  belongs_to :bean_comment
  belongs_to :user
end
