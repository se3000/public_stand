require 'spec_helper'

describe PhoneCall do
  describe "validations" do
    it { should have_valid(:campaign).when(Campaign.all.sample) }
    it { should_not have_valid(:campaign).when(nil) }

    it { should have_valid(:target).when(Target.all.sample) }
    it { should_not have_valid(:target).when(nil) }

    it { should have_valid(:twilio_token).when('any_string') }
    context "uniqueness" do
      before { FactoryGirl.create(:phone_call) }
      it { should_not have_valid(:twilio_token).when(PhoneCall.last.twilio_token) }
    end
  end

  describe "#target_phone_number" do
    it "delegates to #number to target" do
      target = Target.new
      phone_call = PhoneCall.new(target: target)

      expect(target).to receive(:phone_number).and_return("target's phone number")

      expect(phone_call.target_phone_number).to eq "target's phone number"
    end
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
