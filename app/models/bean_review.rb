class BeanReview < ApplicationRecord
  belongs_to :user
  belongs_to :bean

  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :user_id, uniqueness: { scope: :bean_id, message: "You have already reviewed this" }
end
