require 'rails_helper'

RSpec.describe 'rake geocode:station_addresses', type: :task do
  it 'geocodes station addresses that do not have a coordinate_pair record', :immediately_execute_jobs do
    address = create :address # will automatically create an associated station

    task.execute

    expect(address.coordinate_pair).to be_present
  end

  it 'leaves alone addresses that are already geocoded', :immediately_execute_jobs do
    address = create :address, :with_coordinate_pair

    expect { task.execute }.to_not change { address.reload.coordinate_pair.id }
  end
end
