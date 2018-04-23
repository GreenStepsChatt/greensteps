module API
  module GeoJSON
    module V1
      class StationsController < BaseController
        skip_before_action :require_login, only: :index

        expose :stations, -> { Station.all }

        def index
          render json: StationFeatureCollection.new(stations)
        end
      end
    end
  end
end
