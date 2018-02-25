class StationForm < ApplicationForm
  attr_accessor :name, :street, :city, :state, :zip

  validate_models :station, :address

  def save!
    ActiveRecord::Base.transaction do
      station.save!
      address.save!
    end
  end

  private

  def station
    @station ||= Station.new(name: name)
  end

  def address
    @address ||= station.build_address(
      street: street,
      city: city,
      state: state,
      zip: zip
    )
  end
end
