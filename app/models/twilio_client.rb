class TwilioClient
  SID = ENV['TWILIO_SID']
  AUTH_TOKEN = ENV['TWILIO_AUTH_TOKEN']
  OUTGOING_APP_ID = ENV['TWILIO_APP_ID']

  def self.outgoing_twiml
    Twilio::TwiML::Response.new do |response|
      response.Say 'Please hold while we connect your call.', :voice => 'woman'
      response.Dial callerId: '+15186213184' do |dial|
        dial.Number '+15183346656'
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
