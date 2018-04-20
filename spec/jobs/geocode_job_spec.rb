require 'rails_helper'

RSpec.describe GeocodeJob, type: :job do
  it 'creates the coordinate pair record' do
    address = create :address, coordinate_pair: nil

    GeocodeJob.perform_now(address)

    expect(address.coordinate_pair).to have_attributes stubbed_coords
  end

  context 'when the API request fails' do
    around(:each) do |example|
      Geocoder.configure(lookup: :google)
      stub_request(:any, /googleapis/).to_return(
        status: 403,
        body: '{ "results" : [], "status" : "OVER_QUERY_LIMIT" }'
      )

      example.run

      Geocoder.configure(lookup: :test)
    end

    it 'is rescheduled for later' do
      address = create :address, coordinate_pair: nil
      job = GeocodeJob.new(address)

      expect(job).to receive(:retry_job)

      job.perform_now
    end
  end
end
