require 'spec_helper'

describe PhoneCallsController do
  let(:user) { users(:gillian) }

  before { log_in user }

  describe "#create" do
    let(:campaign) { campaigns(:clear_water_campaign) }

    it "creates a new record of a call" do
      expect {
        post :create, campaign_id: campaign.id
      }.to change { campaign.phone_calls.count }.by(+1)
    end

    it "returns JSON with the hash included" do
      phone_call = double(PhoneCall, twilio_token: 'twilioToken')
      Campaign.any_instance
        .stub_chain(:phone_calls, :create)
        .and_return(phone_call)

      post :create, campaign_id: campaign.id

      twilio_token = JSON.parse(response.body)['twilio_token']
      expect(twilio_token).to eq phone_call.twilio_token
    end
  end
end
