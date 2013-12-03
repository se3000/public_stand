class TwilioClient
  SID = ENV['TWILIO_SID']
  AUTH_TOKEN = ENV['TWILIO_AUTH_TOKEN']
  OUTGOING_APP_ID = ENV['TWILIO_APP_ID']

  def self.outgoing_token
    new.outgoing_token
  end

  def outgoing_token
    capability = generate_capability
    capability.allow_client_outgoing OUTGOING_APP_ID
    capability.generate
  end


  private

  def generate_capability
    Twilio::Util::Capability.new SID, AUTH_TOKEN
  end
end
