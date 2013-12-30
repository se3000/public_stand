class PhoneCallsController < ApplicationController

  def create
    campaign = Campaign.find(params[:campaign_id])
    target = campaign.targets.first

    phone_call = campaign.phone_calls.create(target: target)

    render json: {
      phone_call_id: phone_call.id,
      twilio_token: phone_call.twilio_token
    }
  end
end
