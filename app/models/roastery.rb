class Roastery < ApplicationRecord
  belongs_to :user
  has_many :roastery_comments
  has_many :roastery_reviews, dependent: :destroy
  has_many :favourite_roasteries
  has_many :beans
  has_many :locations, dependent: :destroy
  accepts_nested_attributes_for :locations, allow_destroy: true

  validates :name, presence: true
  validates :description, presence: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  def average_rating
    return 0 if roastery_reviews.empty?
    roastery_reviews.average(:rating).round(1)
  end
end
