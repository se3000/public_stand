require 'spec_helper'

describe PhoneCallsController, twilio: true do
  let(:user) { users(:gillian) }

  before do
    log_in user
    request.env["HTTP_REFERER"] = "http://test.host/"
  end

  describe "#create" do
    let(:campaign_target) { campaign_targets(:claire_campaign_target) }
    let(:phone_call_params) { {campaign_target_id: campaign_target.id} }

    it "associates the call record the campaign target" do
      expect {
        post :create, phone_call_params
      }.to change { campaign_target.phone_calls.count }.by(+1)
    end

    it "returns JSON with the token and id included" do
      phone_call = double(PhoneCall, id: 10, twilio_token: 'twilioToken', from_number?: false)
      PhoneCall.stub(create: phone_call)

      post :create, phone_call_params

      parsed = JSON.parse(response.body)
      expect(parsed['phone_call_id']).to eq 10
      expect(parsed['twilio_token']).to eq phone_call.twilio_token
    end

    context "when there is a #from_number" do
      it "has Twilio call the from_number" do
        PhoneCall.any_instance.should_receive :start

        post :create, phone_call_params.merge(phone_call: {from_number: "+15183346656"})
      end
    end

    context "when there is no #from_number" do
      it "does not call the from_number" do
        PhoneCall.any_instance.should_not_receive :start

        post :create, phone_call_params.merge(phone_call: {})
      end
    end
  end
end

describe "PhoneCallsController::Params" do
  let(:campaign_target) { campaign_targets(:claire_campaign_target) }

  describe ".clean" do
    let(:params) do
      ActionController::Parameters.new(
        campaign_target_id: campaign_target.id,
        phone_call: {
          from_number: '+15183346656',
        }
      )
    end

    it "sets the target and the campaign" do
      cleaned = PhoneCallsController::Params.clean(params)

      expect(cleaned).to eq({
        "campaign_target"    => campaign_target,
        "supporter_phone_number" => '+15183346656'
      })
    end
  end
end
