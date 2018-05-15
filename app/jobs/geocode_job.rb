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
    geocoded_address =
      address.respond_to?(:geocode) ? address : GeocodedAddress.new(address)
    geocoded_address.geocode
  end
end
