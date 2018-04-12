require 'rails_helper'

RSpec.describe GeocodeJob, type: :job do
  it 'creates the coordinate pair record' do
    address = create :address, coordinate_pair: nil

    GeocodeJob.perform_now(address)

    expect(address.coordinate_pair).to have_attributes stubbed_coords
  end
end
