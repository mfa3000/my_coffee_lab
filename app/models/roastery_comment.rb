class RoasteryComment < ApplicationRecord
  belongs_to :roastery
  belongs_to :user
  has_many :roastery_comment_votes
end
