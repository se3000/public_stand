require 'spec_helper'

describe TwilioClient do
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

  describe "outgoing_twiml" do
    it "returns a TwiML response to call Steve's phone" do
      expect(TwilioClient.outgoing_twiml).to be_a Twilio::TwiML::Response
    end
  end
end
