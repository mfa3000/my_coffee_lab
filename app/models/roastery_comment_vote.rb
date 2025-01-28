class RoasteryCommentVote < ApplicationRecord
  belongs_to :user
  belongs_to :roastery_comment
end
