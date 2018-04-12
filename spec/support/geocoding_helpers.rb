module GeocodingHelpers
  def stubbed_coords(query_text = nil)
    coords = Geocoder::Lookup::Test.read_stub(query_text).first['coordinates']
    { latitude: coords[0], longitude: coords[1] }
  end
end

RSpec.configure do |config|
  config.include GeocodingHelpers
end
