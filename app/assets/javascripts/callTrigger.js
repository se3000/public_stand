callTrigger = function callTrigger(element) {
  var $element = $(element);

  $element.click(function () {
    var url = '/campaigns/' + $element.data('campaign-id') + '/phone_calls';
    $.ajax({
      type: 'POST',
      url: url,
      beforeSend: function (xhr) { xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')) },
      success: function (data, textStatus, jqXHR) {
        Twilio.Device.setup(data.twilio_token);
        Twilio.Device.connect();
      }
    });
  });
}
