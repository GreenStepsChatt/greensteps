class AddressGeocoder
  def initialize(address)
    raise AddressNotSavedError if address.changed?
    @address = address
  end

  def geocode
    return false unless coords_need_to_be_updated?
    GeocodeJob.perform_later(@address)
  end

  private

  def coords_need_to_be_updated?
    @address.present? && @address.coordinate_pair_stale?
  end

  class AddressNotSavedError < StandardError
    def initialize(msg = 'Address must be saved before gecoding')
      super
    end
  end
end
