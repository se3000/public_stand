class TwilioCallbacksController < ApplicationController

  def outbound_voice
    phone_call = PhoneCall.find(params[:phone_call_id])
    phone_call.update_attributes(Params.clean(params))
    twiml = TwilioClient.outbound_twiml_for phone_call

    render xml: twiml.text
  end

  def voice_status
    if phone_call = PhoneCall.find_by_sid(params[:CallSid])
      phone_call.update_attributes(Params.clean(params))
    end
    render nothing: true
  end

  class Params
    def self.clean(fresh)
      {
        sid: fresh['CallSid'],
        twilio_client_from: fresh["From"].to_s.gsub(/^client:/, ''),
        twilio_client_to: fresh["To"].to_s.gsub(/^client:/, ''),
        status: fresh["CallStatus"],
        direction: fresh["Direction"],
        api_version: fresh["ApiVersion"],
        minutes_billed: fresh["Duration"],
        call_duration: fresh["CallDuration"],
        forwarded_from: fresh["ForwardedFrom"],
        from_city: fresh["FromCity"],
        from_state: fresh["FromState"],
        from_zip: fresh["FromZip"],
        from_country: fresh["FromCountry"],
        to_city: fresh["ToCity"],
        to_state: fresh["ToState"],
        to_zip: fresh["ToZip"],
        to_country: fresh["ToCountry"]
      }
    end
  end
end
