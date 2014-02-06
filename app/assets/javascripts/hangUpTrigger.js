hangUpTrigger = function hangUpTrigger(element) {
  var $element = $(element);

  $element.click(function () {
    Twilio.Device.disconnectAll();
    $('#instruction').foundation('reveal', 'close');
    event.preventDefault();
  });
}
