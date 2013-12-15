require 'spec_helper'

describe PhoneCall do
  describe "validations" do
    it { should have_valid(:twilio_token).when('any_string') }
    context "uniqueness" do
      before { FactoryGirl.create(:phone_call) }
      it { should_not have_valid(:twilio_token).when(PhoneCall.last.twilio_token) }
    end

    it { should have_valid(:campaign).when(Campaign.all.sample) }
    it { should_not have_valid(:campaign).when(nil) }
  end

  describe "on create" do
    let(:phone_call) { FactoryGirl.build(:phone_call) }
    it "generates a  twilio token before" do
      expect(phone_call.twilio_token).to be_nil

      phone_call.save

      expect(phone_call.twilio_token).not_to be_nil
    end
  end
end
