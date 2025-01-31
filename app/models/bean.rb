class Bean < ApplicationRecord
  belongs_to :user
  belongs_to :roastery
  has_many :bean_reviews, dependent: :destroy
  has_many :favourite_beans, dependent: :destroy
  has_many :bean_comments, dependent: :destroy
  has_many :recipes, dependent: :destroy

  validates :name, :description, presence: true
  validates :roastery_id, presence: true

  def average_rating
    return 0 if bean_reviews.empty?
    bean_reviews.average(:rating).round(1)
  end
end
