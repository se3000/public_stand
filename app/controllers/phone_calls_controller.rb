class PhoneCallsController < ApplicationController

  def create
    campaign = Campaign.find(params[:campaign_id])
    phone_call = campaign.phone_calls.create
    render json: { twilio_token: phone_call.twilio_token }
  end
end
