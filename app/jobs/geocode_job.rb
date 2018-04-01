class GeocodeJob < ApplicationJob
  queue_as :default

  def perform(address)
    latitude, longitude = Geocoder.coordinates(address.to_sentence)
    if address.coordinate_pair.present?
      address.coordinate_pair.update(latitude: latitude, longitude: longitude)
    else
      address.create_coordinate_pair(latitude: latitude, longitude: longitude)
    end
  end
end
