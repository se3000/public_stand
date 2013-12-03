callTrigger = function callTrigger(element) {
  $element = $(element);

  $element.click(function () {
    console.log('here');
    Twilio.Device.setup();
  });
}
