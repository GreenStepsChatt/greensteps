module Admins
  class StationsController < BaseController
    expose :station_form
    expose :station

    def new; end

    def create
      if station_form.save
        redirect_to admins_dashboard_path, notice: t('.success')
      else
        render 'new'
      end
    end

    def update
      station.assign_attributes(update_station_params)
      situation = determine_situation(station)

      if situation == 'edit address'
        station.address.assign_attributes(update_address_params)
        if station.save && station.address.save
          redirect_to admins_dashboard_path, notice: t('.success')
        else
          flash[:notice] = t('.alert')
          render :edit
        end
      elsif situation == 'delete address, create coordinate_pair'
        station.address.delete
        station.coordinate_pair = create_coordinate_pair
        if station.coordinate_pair.save && station.save
          redirect_to admins_dashboard_path, notice: t('.success')
        else
          flash[:notice] = t('.alert')
          render :edit
        end
      elsif situation == 'edit coordinate_pair'
        station.coordinate_pair.assign_attributes(update_coordinate_pair_params)
        if station.save && station.coordinate_pair.save
          redirect_to admins_dashboard_path, notice: t('.success')
        else
          flash[:notice] = t('.alert')
          render :edit
        end
      elsif situation == 'delete coordinate_pair, create address'
        station.coordinate_pair.delete
        station.address = create_address
        if station.address.save && station.save
          redirect_to admins_dashboard_path, notice: t('.success')
        else
          flash[:notice] = t('.alert')
          render :edit
        end
      else
        flash[:notice] = t('.alert')
        render :edit
      end
    end

    private

    def determine_situation(station)
      if !station.address.nil? && params[:longitude] == '' && params[:latitude] == ''
        'edit address'
      elsif !station.address.nil? && params[:longitude] != '' && params[:latitude] != ''
        'delete address, create coordinate_pair'
      elsif station.address.nil? && params[:street] == '' && params[:city] == '' && params[:state] == '' && params[:zip] == ''
        'edit coordinate_pair'
      elsif station.address.nil? && params[:street] != '' && params[:city] != '' && params[:state] != '' && params[:zip] != ''
        'delete coordinate_pair, create address'
      else
        'incomplete information'
      end
    end

    def update_station_params
      params.require(:station).permit(:name)
    end

    def update_coordinate_pair_params
      params.require(:coordinate_pair).permit(:longitude, :latitude)
    end

    def update_address_params
      params.require(:address).permit(:street, :city, :state, :zip)
    end

    def station_form_params
      params.require(:station_form).permit(:name, :street, :city, :state, :zip,
                                           :latitude, :longitude)
    end

    def create_address
      Address.create(street: params[:street], city: params[:city], state: params[:state], zip: params[:zip])
    end

    def create_coordinate_pair
      CoordinatePair.create(longitude: params[:longitude], latitude: params[:latitude])
    end
  end
end
