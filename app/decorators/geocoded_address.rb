class GeocodedAddress
  delegate_missing_to :@address

  def initialize(address)
    @address = address

    @address.singleton_class.class_eval do
      after_commit on: %i[create update] do
        next false unless coordinate_pair_stale?
        GeocodeJob.perform_later(self)
      end
    end
  end
end
