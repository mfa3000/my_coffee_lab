class FavouriteBean < ApplicationRecord
  belongs_to :bean
  belongs_to :user
end
