module Admins
  class StationsController < BaseController
    expose :station

    def new; end

    def create
      if station.save
        redirect_to admins_dashboards_show_path, notice: t('.success')
      else
        render 'new'
      end
    end

    private

    def station_params
      params.require(:station).permit(:name, :lat, :lng)
    end
  end
end
