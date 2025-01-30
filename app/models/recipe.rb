class Recipe < ApplicationRecord
  belongs_to :bean
  belongs_to :user

  validates :name, presence: true
  validates :instructions, presence: true
end
