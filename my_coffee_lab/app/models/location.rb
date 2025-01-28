class Location < ApplicationRecord
  belongs_to :Roastery

  validates :address, presence: true
  validates :location_type, inclusion: { in: ["Cafe", "Roastery and Cafe", "Warehouse"] }
end
