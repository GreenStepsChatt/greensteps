class CoordinatePair < ApplicationRecord
  belongs_to :locateable, polymorphic: true

  validates :latitude, :longitude, presence: true
end
