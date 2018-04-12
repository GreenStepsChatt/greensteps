class GeocodedAddress
  delegate_missing_to :@address

  def initialize(address)
    @address = address

    @address.singleton_class.class_eval do
      after_update { coordinate_pair.destroy if saved_value_changes? }

      after_commit on: %i[create update] do
        next unless coordinate_pair.blank? || coordinate_pair.destroyed?
        GeocodeJob.perform_later(self)
      end
    end
  end

  def geocode
    latitude, longitude = Geocoder.coordinates(to_sentence)
    create_coordinate_pair(latitude: latitude, longitude: longitude)
  end
end
