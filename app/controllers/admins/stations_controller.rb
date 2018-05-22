module Admins
  class StationsController < BaseController
    expose :station_form

    def new; end

    def create
      if station_form.save
        redirect_to admins_dashboard_path, notice: t('.success')
      else
        render 'new'
      end
    end

    private

    def station_form_params
      params.require(:station).permit(:name, :street, :city, :state, :zip,
                                      :latitude, :longitude)
    end
  end
end
