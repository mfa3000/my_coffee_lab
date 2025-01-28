class Roastery < ApplicationRecord
  belongs_to :user
  has_many :roastery_comments
  has_many :roastery_reviews
  has_many :favourite_roasteries
  has_many :beans
  has_many :locations, dependent: :destroy
  accepts_nested_attributes_for :locations, allow_destroy: true

  validates :name, presence: true
  validates :description, presence: true
end
