class Station < ApplicationRecord
  validates :name, presence: true

  # If the admin entered a latitude and longitude by hand, it will be directly
  # linked to the station via the coordinate_pair association. If they entered
  # an address, then the coordinates from the geocoding service will be attached
  # to the address record itself (in the address's coordinate_pair association).
  has_one :address,
          as: :addressable,
          dependent: :destroy,
          inverse_of: :addressable # TODO: not needed in rails 5.2
  has_one :coordinate_pair,
          as: :locateable,
          dependent: :destroy,
          inverse_of: :locateable # TODO: not needed in rails 5.2
end
