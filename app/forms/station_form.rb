class StationForm < ApplicationForm
  attr_accessor :name, :street, :city, :state, :zip

  def save
    super { save! }
  end

  def save!
    station = Station.create!(name: name)
    station.create_address!(
      street: street,
      city: city,
      state: state,
      zip: zip
    )
  end
end
