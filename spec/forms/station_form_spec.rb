require 'rails_helper'

RSpec.describe StationForm, type: :form do
  it { should respond_to :name, :street, :city, :state, :zip }

  describe '#save' do
    it 'creates a station record' do
      station_form = build :station_form, name: 'Dirty Swamp'

      expect { station_form.save }.to change { Station.count }.by(1)
      expect(Station).to exist name: 'Dirty Swamp'
    end

    it 'creates an associated address record' do
      station_form = build :station_form,
                           street: '101 Main Street',
                           city: 'Chattanooga',
                           state: 'TN',
                           zip: '10101'

      expect { station_form.save }.to change { Address.count }.by(1)
      expect(Address).to exist street: '101 Main Street'
    end
  end

  context 'station model is invalid' do
    subject { build :station_form, :invalid_station }
    it { should be_invalid }
  end

  context 'address model is invalid' do
    subject { build :station_form, :invalid_address }
    it { should be_invalid }
  end
end
