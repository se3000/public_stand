class TwilioClient
  SID = ENV['TWILIO_SID']
  AUTH_TOKEN = ENV['TWILIO_AUTH_TOKEN']
  OUTGOING_APP_ID = ENV['TWILIO_APP_ID']
  ROOT_URL = ENV['ROOT_URL']
  APP_PHONE_NUMBER = '5186213184'
  STATUS_CALLBACK = ENV['TWILIO_STATUS_CALLBACK']

  def self.outbound_twiml_for(phone_call, options = {})
    Twilio::TwiML::Response.new do |response|
      if phone_call.fcc?
        response.Say "Hold on while we connect you, we will automatically route you to the FCC complaints line."
      end
      response.Dial callerId: "+1#{phone_call.outgoing_number}" do |dial|
        dial.Number("+1#{phone_call.target_phone_number}", sendDigits: (phone_call.fcc? ? "ww1ww5wwwwwww1" : nil))
      end
    end
  end

  def self.outgoing_token
    new.outgoing_token
  end

  def self.begin_call(phone_call)
    new.begin_call(phone_call)
  end

  def outgoing_token
    capability = new_capability
    capability.allow_client_outgoing OUTGOING_APP_ID
    capability.generate
  end

  def begin_call(phone_call)
    new_client.account.calls.create(
      from: "+1#{phone_call.outgoing_number}",
      to: "+1#{phone_call.from_number}",
      url: "#{ROOT_URL}/twilio_outbound_voice_callback?phone_call_id=#{phone_call.id}",
      method: 'GET',
      status_callback: STATUS_CALLBACK, #necessary?
      status_callback_method: 'GET'     #necessary?
    )
  end


  private

  def new_capability
    Twilio::Util::Capability.new SID, AUTH_TOKEN
  end

  def new_client
    Twilio::REST::Client.new SID, AUTH_TOKEN
  end
end
