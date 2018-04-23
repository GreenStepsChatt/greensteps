require 'rails_helper'

RSpec.describe API::GeoJSON::V1::StationsController, type: :controller do
  describe '#index' do
    it 'returns a listing of all of the stations in GeoJSON format',
       :immediately_execute_jobs do
      create :station_form
      create_list :station_form, 2, :with_coords_only

      get :index

      # TODO: why is this spec so slow? if it is the encoding we might need to
      #       keep a cached response around
      features = RGeo::GeoJSON.decode(
        response.body,
        geo_factory: RGeo::Cartesian.simple_factory(srid: 4326)
      )
      expect(features).to have(3).items
    end
  end
end
