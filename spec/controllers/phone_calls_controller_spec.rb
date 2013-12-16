require 'spec_helper'

describe PhoneCallsController do
  let(:user) { users(:gillian) }

  before { log_in user }

  describe "#create" do
    let(:campaign) { campaigns(:clear_water_campaign) }
    let(:target) { campaign.targets.first }

    it "creates a new call record assocaited with the campaign" do
      expect {
        post :create, campaign_id: campaign.id
      }.to change { campaign.phone_calls.count }.by(+1)
    end

    it "associates the call record the campaign's first target" do
      expect {
        post :create, campaign_id: campaign.id
      }.to change { target.phone_calls.count }.by(+1)
    end

    it "returns JSON with the token and id included" do
      phone_call = double(PhoneCall, id: 10, twilio_token: 'twilioToken')
      Campaign.any_instance
        .stub_chain(:phone_calls, :create)
        .and_return(phone_call)

      post :create, campaign_id: campaign.id

      parsed = JSON.parse(response.body)
      expect(parsed['phone_call_id']).to eq 10
      expect(parsed['twilio_token']).to eq phone_call.twilio_token
    end
  end
end
