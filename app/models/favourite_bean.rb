class FavouriteBean < ApplicationRecord
  belongs_to :bean
  belongs_to :user

  validates :user_id, uniqueness: { scope: :bean_id }
end
