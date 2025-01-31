class Location < ApplicationRecord
  belongs_to :roastery

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  validates :address, presence: true
  validates :location_type, presence: true, inclusion: { in: ["Cafe", "Roastery and Cafe", "Warehouse"] }

end
