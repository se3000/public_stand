class TwilioClient
  SID = ENV['TWILIO_SID']
  AUTH_TOKEN = ENV['TWILIO_AUTH_TOKEN']
  OUTGOING_APP_ID = ENV['TWILIO_APP_ID']

  def self.outbound_twiml_for phone_call
    Twilio::TwiML::Response.new do |response|
      response.Dial callerId: '+15186213184' do |dial|
        dial.Number phone_call.target_phone_number
      end
    end
  end

  def self.outgoing_token
    new.outgoing_token
  end

  def outgoing_token
    capability = new_capability
    capability.allow_client_outgoing OUTGOING_APP_ID
    capability.generate
  end


  private

  def new_capability
    Twilio::Util::Capability.new SID, AUTH_TOKEN
  end
end
