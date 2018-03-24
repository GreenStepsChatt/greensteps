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

    def edit
      @station = Station.find(params[:id])
    end

    def update
      @station = Station.find(params[:id])
      @station.name = params[:station][:name]
      @address = @station.address
      @address.street = params[:address][:street]
      @address.city = params[:address][:city]
      @address.state = params[:address][:state]
      @address.zip = params[:address][:zip]

      if @station.save && @address.save
        redirect_to admins_dashboard_path, notice: t('.success')
      else
        render :edit, alert: t('.alert')
      end
    end

    private

    def station_form_params
      params.require(:station_form).permit(:name, :street, :city, :state, :zip)
    end
  end
end
