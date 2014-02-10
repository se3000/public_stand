class TwilioClient
  SID = ENV['TWILIO_SID']
  AUTH_TOKEN = ENV['TWILIO_AUTH_TOKEN']
  OUTGOING_APP_ID = ENV['TWILIO_APP_ID']
  ROOT_URL = ENV['ROOT_URL']
  APP_PHONE_NUMBER = '+15186213184'

  def self.outbound_twiml_for phone_call
    Twilio::TwiML::Response.new do |response|
      response.Dial callerId: APP_PHONE_NUMBER do |dial|
        dial.Number "+1#{phone_call.target_phone_number}"
      end
    end
  end

  def self.outgoing_token
    new.outgoing_token
  end

  def self.begin_call phone_call
    new.begin_call(phone_call)
  end

  def outgoing_token
    capability = new_capability
    capability.allow_client_outgoing OUTGOING_APP_ID
    capability.generate
  end

  def begin_call(phone_call)
    new_client.account.calls.create(
      from: APP_PHONE_NUMBER,
      to: "+1#{phone_call.from_number}",
      url: "#{ROOT_URL}/twilio_outbound_voice_callback?phone_call_id=#{phone_call.id}",
      method: 'GET'
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
