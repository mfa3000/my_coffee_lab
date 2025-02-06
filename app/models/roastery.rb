class Roastery < ApplicationRecord
  belongs_to :user
  has_many :roastery_comments, dependent: :destroy
  has_many :roastery_reviews, dependent: :destroy
  has_many :favourite_roasteries, dependent: :destroy
  has_many :beans
  has_many :locations, dependent: :destroy
  accepts_nested_attributes_for :locations, allow_destroy: true
  has_many_attached :photos
  has_one_attached :main_photo

  validates :name, presence: true
  validates :description, presence: true

  geocoded_by :address

  def average_rating
    return 0 if roastery_reviews.empty?
    roastery_reviews.average(:rating).round(1)
  end

  def favorited_by?(user)
    favourite_roasteries.exists?(user: user)
  end
end
