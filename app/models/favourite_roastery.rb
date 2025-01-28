class FavouriteRoastery < ApplicationRecord
  belongs_to :roastery
  belongs_to :user
end
