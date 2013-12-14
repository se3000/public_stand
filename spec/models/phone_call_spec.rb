require 'spec_helper'

describe PhoneCall do
  describe "validations" do
    it { should have_valid(:twilio_token).when('any_string') }
    it { should_not have_valid(:twilio_token).when(nil, '') }

    it { should have_valid(:campaign).when(Campaign.all.sample) }
    it { should_not have_valid(:campaign).when(nil) }
  end
end
