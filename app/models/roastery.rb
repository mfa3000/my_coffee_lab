class Roastery < ApplicationRecord
  belongs_to :user
  has_many :roastery_comments
  has_many :roastery_reviews
  has_many :favourite_roasteries
  has_many :beans
  has_many :locations
end
