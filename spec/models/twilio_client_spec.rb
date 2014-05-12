require 'spec_helper'

describe TwilioClient do
  describe ".outbound_twiml_for" do
    let(:response) { double(:twilio_response) }
    let(:dialer) { double(:twilio_dialer) }
    let(:phone_call) { double(:twiml_response, target_phone_number: 'any#', outgoing_number: 'another#', fcc?: nil) }

    it "returns a TwiML response calling the phone call's number" do
      expect(Twilio::TwiML::Response).to receive(:new)
        .and_yield response
      expect(response).to receive(:Dial)
        .and_yield(dialer)
      expect(dialer).to receive(:Number)
        .with("+1#{phone_call.target_phone_number}", sendDigits: nil)

      TwilioClient.outbound_twiml_for phone_call
    end
  end

  describe ".outgoing_token" do
    it "asks an instance for an outgoing token" do
      TwilioClient.any_instance
        .should_receive(:outgoing_token)
        .and_return('OutgoingToken4535')

      expect(TwilioClient.outgoing_token).to eq('OutgoingToken4535')
    end
  end

  describe "#outgoing token" do
    let(:twilio_app_id) { ENV['TWILIO_APP_ID'] }
    let(:capability) { double(Twilio::Util::Capability) }

    it "creates a new Twilio token" do
      expect(capability).to receive(:allow_client_outgoing).with(twilio_app_id)
      expect(capability).to receive(:generate).and_return('OutgoingToken98345')

      Twilio::Util::Capability.stub(new: capability)

      TwilioClient.outgoing_token.should == 'OutgoingToken98345'
    end
  end

  describe "#begin_call" do
    let(:campaign_target) { FactoryGirl.build(:campaign_target, twilio_number: '5183346656') }
    let(:phone_call) { FactoryGirl.build(:phone_call, from_number: 'a', campaign_target: campaign_target) }
    let(:calls) { double(:calls) }
    let(:client) { TwilioClient.new }

    it "creates a new call through the twilio rest client" do
      Twilio::REST::Client.any_instance
        .stub_chain(:account, :calls)
        .and_return(calls)

      expect(calls).to receive(:create)
        .with({
          from: "+1#{phone_call.outgoing_number}",
          to: "+1#{phone_call.from_number}",
          url: "#{ENV['ROOT_URL']}/twilio_outbound_voice_callback?phone_call_id=#{phone_call.id}",
          method: 'GET',
          status_callback: ENV['TWILIO_STATUS_CALLBACK'],
          status_callback_method: 'GET'
        })

      client.begin_call phone_call
    end
  end
end
