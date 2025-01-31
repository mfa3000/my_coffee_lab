class FavouriteRoastery < ApplicationRecord
  belongs_to :roastery
  belongs_to :user

  validates :user_id, uniqueness: { scope: :roastery_id }
end
