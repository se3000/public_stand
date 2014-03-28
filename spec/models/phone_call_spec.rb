require 'spec_helper'

describe PhoneCall do
  describe "validations" do
    it { should have_valid(:campaign_target).when(FactoryGirl.create(:campaign_target)) }
    it { should_not have_valid(:campaign_target).when(nil) }

    it { should have_valid(:twilio_token).when('any_string') }
    context "uniqueness" do
      let(:old_call) { FactoryGirl.create(:phone_call) }
      it { should_not have_valid(:twilio_token).when(old_call.twilio_token) }
    end
  end

  describe "on create" do
    let(:campaign_target) { FactoryGirl.create(:campaign_target) }
    let(:phone_call) { PhoneCall.new(campaign_target: campaign_target) }
    it "generates a  twilio token before" do
      expect(phone_call.twilio_token).to be_nil

      phone_call.save

      expect(phone_call.twilio_token).not_to be_nil
    end
  end

  describe ".completed" do
    subject { PhoneCall.completed }
    let!(:completed) { FactoryGirl.create(:phone_call, status: 'completed') }
    let!(:uncompleted) { FactoryGirl.create(:phone_call, status: 'not completed') }

    it { should include completed }
    it { should_not include uncompleted }
  end

  describe "#target_phone_number" do
    it "delegates to #number to target" do
      target = Target.new
      campaign_target = CampaignTarget.new(target: target)
      phone_call = PhoneCall.new(campaign_target: campaign_target)

      expect(target).to receive(:phone_number).and_return("target's phone number")

      expect(phone_call.target_phone_number).to eq "target's phone number"
    end
  end

  describe "#start" do
    let(:phone_call) { FactoryGirl.build(:phone_call) }

    it "tells the Twilio API to start the call" do
      TwilioClient.better_receive(:begin_call)
        .with(phone_call)

      phone_call.start
    end
  end

  describe "#outgoing_number" do
    it "returns the campaign target's outgoing phone number" do
      campaign_target = CampaignTarget.new
      phone_call = PhoneCall.new(campaign_target: campaign_target)

      expect(campaign_target).to receive(:outgoing_number).and_return("outgoing phone number")

      expect(phone_call.outgoing_number).to eq "outgoing phone number"
    end
  end

  describe "#supporter_phone_number=" do
    it "removes non numeric characters" do
      phone_call = PhoneCall.new
      phone_call.supporter_phone_number = '(518)334-6656'
      expect(phone_call.from_number).to eq('5183346656')

      phone_call = PhoneCall.new
      phone_call.supporter_phone_number = '518.334.6656'
      expect(phone_call.from_number).to eq('5183346656')

      phone_call = PhoneCall.new
      phone_call.supporter_phone_number = '1.2.3.4'
      expect(phone_call.from_number).to eq('1234')
    end
  end
end
