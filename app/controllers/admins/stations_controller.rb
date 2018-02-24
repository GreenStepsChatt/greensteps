module Admins
  class StationsController < BaseController
    expose :station_form

    def new; end

    def create
      if station_form.save
        redirect_to admins_dashboards_show_path, notice: t('.success')
      else
        render 'new'
      end
    end

    private

    def station_form_params
      params.require(:station_form).permit(
        :name, :street, :city, :state, :zip, :latitude, :longitude
      )
    end
  end
end
