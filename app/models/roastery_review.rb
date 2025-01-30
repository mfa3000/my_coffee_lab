class RoasteryReview < ApplicationRecord
  belongs_to :roastery
  belongs_to :user

  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :user_id, uniqueness: { scope: :roastery_id, message: "You have already reviewed this roastery" }
end
