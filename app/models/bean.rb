class Bean < ApplicationRecord
  belongs_to :user
  belongs_to :roastery
  has_many :bean_reviews
  has_many :favourite_beans
  has_many :bean_comments
  has_many :recipes, dependent: :destroy

  validates :name, :description, presence: true
  validates :roastery_id, presence: true

  after_create_commit -> { broadcast_append_to "bean_#{bean.id}_comments" }
end
