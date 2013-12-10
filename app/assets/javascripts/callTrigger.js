callTrigger = function callTrigger(element) {
  $element = $(element);
  Twilio.Device.setup($element.data('token'));

  $element.click(function () {
    Twilio.Device.connect()
  });
}
