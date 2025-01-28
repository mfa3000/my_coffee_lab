class Location < ApplicationRecord
  belongs_to :roastery

  validates :address, presence: true
  validates :location_type, presence: true, inclusion: { in: ["Cafe", "Roastery and Cafe", "Warehouse"] }

end
