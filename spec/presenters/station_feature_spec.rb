require 'rails_helper'

RSpec.describe StationFeature do
  describe 'to_h' do
    it 'returns a hash representation of the station in the GeoJSON format' do
      create :station_form, :with_coords_only
      station = Station.first

      hash = StationFeature.new(station).to_h

      expect(hash).to eq(
        'type' => 'Feature',
        'id' => station.id,
        'properties' => {
          'title' => station.name
        },
        'geometry' => {
          'type' => 'Point',
          'coordinates' => station.reverse_coordinates
        }
      )
    end
  end
end
