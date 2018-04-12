class GeocodeJob < ApplicationJob
  queue_as :default

  [
    SocketError,
    Timeout::Error,
    Geocoder::OverQueryLimitError,
    Geocoder::RequestDenied,
    Geocoder::ServiceUnavailable
  ].each do |error_class|
    retry_on error_class, wait: :exponentially_longer
  end

  def perform(address)
    GeocodedAddress.new(address).geocode
  end
end
