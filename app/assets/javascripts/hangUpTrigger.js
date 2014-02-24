hangUpTrigger = function hangUpTrigger(element) {
  var $element = $(element);

  $element.click(function (event) {
    if (! $element.hasClass('disabled')) {
      Twilio.Device.disconnect(PublicStand.displayNextStep);
      Twilio.Device.disconnectAll();
    }
    event.preventDefault();
  });
}
