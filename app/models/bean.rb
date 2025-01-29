class Bean < ApplicationRecord
  belongs_to :user
  belongs_to :roastery
  has_many :bean_reviews
  has_many :favourite_beans
  has_many :bean_comments

  validates :name, presence: true
  validates :description, presence: true
  validates :roastery_id, presence: true
end
