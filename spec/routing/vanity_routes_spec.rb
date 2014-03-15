require 'spec_helper'

describe "routing" do
  it 'does not override twilio callbacks' do
    expect(get: '/twilio_outbound_voice_callback').to route_to(controller: 'twilio_callbacks',
                                                               action: 'outbound_voice')

    expect(get: '/twilio_voice_status_callback').to route_to(controller: 'twilio_callbacks',
                                                             action: 'voice_status')
  end
end
