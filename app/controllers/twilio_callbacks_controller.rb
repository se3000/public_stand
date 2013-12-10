class TwilioCallbacksController < ApplicationController
  skip_before_filter :ensure_authenticated

  def outbound_voice
    twiml = TwilioClient.outgoing_twiml
    render xml: twiml.text
  end
end
