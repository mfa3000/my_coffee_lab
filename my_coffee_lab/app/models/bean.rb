class Bean < ApplicationRecord
  belongs_to :user
  belongs_to :roastery
  has_many :bean_reviews
  has_many :favourite_beans
  has_many :bean_comments
end
