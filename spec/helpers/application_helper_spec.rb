require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#flash_filtered_for_display' do
    it "includes flash messages of types 'alert', 'notice', and 'warning'" do
      allow(helper).to receive(:flash).and_return(
        'alert' => 'This is an alert.',
       'notice' => 'This is a notice.',
      'warning' => 'This is a warning.'
      )

      expect(helper.flash_filtered_for_display).to eq(
        'alert' => 'This is an alert.',
       'notice' => 'This is a notice.',
      'warning' => 'This is a warning.'
      )
    end

    it "doesn't include message types that aren't whitelisted" do
      allow(helper).to receive(:flash).and_return(
        'do_not_display_me' => 'I should not be rendered.'
      )

      expect(helper.flash_filtered_for_display).to be_empty
    end

    it 'is empty if there is no flash' do
      expect(helper.flash_filtered_for_display).to be_empty
    end

    it "doesn't include blank messages" do
      # make sure this spec breaks if "alert" is removed from whitelist
      allow(helper).to receive(:flash).and_return(
        'alert' => 'This is an alert.'
      )

      expect(helper.flash_filtered_for_display).to \
        include('alert' => 'This is an alert.')

      # perform the actual test
      allow(helper).to receive(:flash).and_return('alert' => '')

      expect(helper.flash_filtered_for_display).to be_blank
    end
  end
end
