class TwilioCallbacksController < ApplicationController

  def outbound_voice
    phone_call = PhoneCall.find(params[:phone_call_id])
    twiml = TwilioClient.outbound_twiml_for phone_call

    render xml: twiml.text
  end
end
