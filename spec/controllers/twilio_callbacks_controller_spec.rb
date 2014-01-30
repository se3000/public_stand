require 'spec_helper'

describe TwilioCallbacksController do
  describe "#outbound_voice" do
    let(:phone_call) { phone_calls(:unstarted_call) }

    it "returns TwiML from the requested call record" do
      expect(TwilioClient).to receive(:outbound_twiml_for)
        .with(phone_call)
        .and_return(double(:twiml, text: 'XML?'))

      get :outbound_voice, phone_call_id: phone_call.id, CallSid: '1'

      expect(response).to be_success
    end

    it "updates the SID of the phone call" do
      expect {
        get :outbound_voice, phone_call_id: phone_call.id, CallSid: '6688'
      }.to change{ phone_call.reload.sid }.from(nil).to('6688')
    end
  end
end
