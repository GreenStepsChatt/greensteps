require 'rails_helper'

RSpec.describe StationFeatureCollection do
  describe '#to_h' do
    it 'returns a hash representation of the stations in GeoJSON format',
       :immediately_execute_jobs do
      create :station_form
      create_list :station_form, 2, :with_coords_only

      hash = StationFeatureCollection.new(Station.all).to_h

      expect(hash['type']).to eq 'FeatureCollection'
      expect(hash['features']).to have(3).items
    end
  end
end
