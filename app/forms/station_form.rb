class StationForm < ApplicationForm
  attr_accessor :name, :street, :city, :state, :zip, :latitude, :longitude

  validates_models :station, :address, :coordinate_pair
  validate :at_least_one_of_address_and_coords_present
  validate :only_one_of_address_and_coords_present

  def at_least_one_of_address_and_coords_present
    return if address.present? || coordinate_pair.present?
    errors.add(:base, :at_least_one_addr_coords)
  end

  def only_one_of_address_and_coords_present
    return unless address.present? && coordinate_pair.present?
    errors.add(:base, :only_one_addr_coords)
  end

  def save!
    ActiveRecord::Base.transaction do
      [station.save!, address.save!, coordinate_pair.save!].all?
    end
  end

  private

  def station
    @station ||= Station.new(name: name)
  end

  # TODO: see about refactoring the code below since they're doing the same
  # thing

  def address
    @address ||=
      if address_attributes.present?
        GeocodedAddress.new(station.build_address(address_attributes))
      else
        NullAddress.new
      end
  end

  def coordinate_pair
    @coordinate_pair ||=
      if coordinate_pair_attributes.present?
        station.build_coordinate_pair coordinate_pair_attributes
      else
        NullChildModel.new
      end
  end

  def address_attributes
    @address_attributes ||=
      { street: street, city: city, state: state, zip: zip }.keep_if do |_k, v|
        v.present?
      end
  end

  def coordinate_pair_attributes
    { latitude: latitude, longitude: longitude }.keep_if do |_k, v|
      v.present?
    end
  end

  class NullAddress < NullChildModel
    def to_sentence
      nil
    end
  end
end
