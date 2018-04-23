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

  def latitude
    coordinate_pair.present? ? coordinate_pair.latitude : address.latitude
  end

  def longitude
    coordinate_pair.present? ? coordinate_pair.longitude : address.longitude
  end

  # TODO: this should probably delegate like the above two methods and then we
  # should remove the duplication somehow
  def reverse_coordinates
    [longitude, latitude]
  end
end
