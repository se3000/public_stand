require 'spec_helper'

describe TwilioCallbacksController do
  let(:params) do
    {
      "CallSid"=>"call SID",
      "From"=>"client:from param",
      "To"=>"client:to param",
      "CallStatus"=>"the deets",
      "Direction"=>"1 Direction",
      "ApiVersion"=>"2010-04-01",
      "Duration"=>"2",
      "CallDuration"=>"76",
      "ForwardedFrom"=>"'nother number",
      "FromCity"=>"from city",
      "FromState"=>"from state",
      "FromZip"=>"from zip",
      "FromCountry"=>"from country",
      "ToCity"=>"to city",
      "ToState"=>"to state",
      "ToZip"=>"to zip",
      "ToCountry"=>"to country"
    }
  end

  describe "#outbound_voice" do
    let(:phone_call) { phone_calls(:unstarted_call) }

    it "returns TwiML from the requested call record" do
      expect(TwilioClient).to receive(:outbound_twiml_for)
        .with(phone_call)
        .and_return(double(:twiml, text: 'XML?'))

      get :outbound_voice, params.merge(phone_call_id: phone_call.id)

      expect(response).to be_success
    end

    it "updates the call record" do
      expect {
        get :outbound_voice, params.merge(phone_call_id: phone_call.id, CallSid: '6688')
      }.to change{ phone_call.reload.sid }.from(nil).to('6688')

      expect(phone_call.twilio_client_from).to eq('from param')
      expect(phone_call.twilio_client_to).to eq('to param')
      expect(phone_call.status).to eq('the deets')
      expect(phone_call.direction).to eq('1 Direction')
      expect(phone_call.api_version).to eq('2010-04-01')
      expect(phone_call.call_duration).to eq(76)
      expect(phone_call.minutes_billed).to eq(2)
      expect(phone_call.forwarded_from).to eq("'nother number")
      expect(phone_call.from_city).to eq('from city')
      expect(phone_call.from_state).to eq('from state')
      expect(phone_call.from_zip).to eq('from zip')
      expect(phone_call.from_country).to eq('from country')
      expect(phone_call.to_city).to eq('to city')
      expect(phone_call.to_state).to eq('to state')
      expect(phone_call.to_zip).to eq('to zip')
      expect(phone_call.to_country).to eq('to country')
    end
  end

  describe "#voice_status" do
    let(:phone_call) { phone_calls(:unstarted_call) }

    before { phone_call.update_attributes(sid: params['CallSid']) }

    it "updates the call record" do
      get :voice_status, params

      phone_call.reload

      expect(phone_call.twilio_client_from).to eq('from param')
      expect(phone_call.twilio_client_to).to eq('to param')
      expect(phone_call.status).to eq('the deets')
      expect(phone_call.direction).to eq('1 Direction')
      expect(phone_call.api_version).to eq('2010-04-01')
      expect(phone_call.call_duration).to eq(76)
      expect(phone_call.minutes_billed).to eq(2)
      expect(phone_call.forwarded_from).to eq("'nother number")
      expect(phone_call.from_city).to eq('from city')
      expect(phone_call.from_state).to eq('from state')
      expect(phone_call.from_zip).to eq('from zip')
      expect(phone_call.from_country).to eq('from country')
      expect(phone_call.to_city).to eq('to city')
      expect(phone_call.to_state).to eq('to state')
      expect(phone_call.to_zip).to eq('to zip')
      expect(phone_call.to_country).to eq('to country')
    end
  end
end
