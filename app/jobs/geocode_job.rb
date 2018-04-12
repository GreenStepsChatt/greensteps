class GeocodeJob < ApplicationJob
  queue_as :default

  def perform(address)
    GeocodedAddress.new(address).geocode
  end
end
