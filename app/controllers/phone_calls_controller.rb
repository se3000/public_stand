class PhoneCallsController < ApplicationController

  def create
    phone_call = PhoneCall.create(Params.clean(params))
    phone_call.start if phone_call.from_number?

    render json: {
      phone_call_id: phone_call.id,
      twilio_token: phone_call.twilio_token
    }
  end

  class Params
    def self.clean(params)
      campaign = Campaign.find(params[:campaign_id])

      from = params[:phone_call][:from_number] if params[:phone_call]
      {
        "campaign" => campaign,
        "target" => campaign.targets.first,
        "from_number" => from
      }
    end
  end
end
