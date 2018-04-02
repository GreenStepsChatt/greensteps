require 'rails_helper'

RSpec.describe GeocodeJob, type: :job do
  context 'when the address has an outdated coordinate pair record' do
    it 'saves the new coordinates' do
      address = create :address
      coordinate_pair = create :coordinate_pair,
                               locateable: address,
                               latitude: 0,
                               longitude: 0
      expect(coordinate_pair).to_not have_attributes stubbed_coords('default')

      GeocodeJob.perform_now(address)

      expect(coordinate_pair.reload).to have_attributes stubbed_coords
    end
  end

  context 'when the address does not have coordinate pair record' do
    it 'creates the coordinate pair record' do
      address = create :address

      GeocodeJob.perform_now(address)

      expect(address.coordinate_pair).to have_attributes stubbed_coords
    end
  end
end
