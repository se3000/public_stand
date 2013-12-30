require 'spec_helper'

describe TwilioCallbacksController do
  describe "#outbound_voice" do
    let(:phone_call) { phone_calls(:unstarted_call) }

    it "returns TwiML from the requested call record" do
      expect(TwilioClient).to receive(:outbound_twiml_for)
        .with(phone_call)
        .and_return(double(:twiml, text: 'XML?'))

      get :outbound_voice, phone_call_id: phone_call.id

      expect(response).to be_success
    end
  end
end
