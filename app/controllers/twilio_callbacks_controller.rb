class TwilioCallbacksController < ApplicationController
  skip_before_filter :ensure_authenticated

  def outbound_voice
    phone_call = PhoneCall.find(params[:phone_call_id])
    twiml = TwilioClient.outbound_twiml_for phone_call

    render xml: twiml.text
  end
end
