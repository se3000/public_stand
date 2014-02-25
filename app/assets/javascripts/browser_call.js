BrowserCall = {
  start: function start(options) {
    Twilio.Device.ready(PublicStand.displayInstructions);
    Twilio.Device.setup(options.twilio_token);

    Twilio.Device.connect(PublicStand.displayNextStep);
    Twilio.Device.connect({phone_call_id: options.phone_call_id});

    Twilio.Device.disconnect(PublicStand.displayNextStep);
  }
}
