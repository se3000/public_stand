callTrigger = function callTrigger(element) {
  var $element = $(element);

  $element.click(function () {
    var url = '/campaigns/' + $element.data('campaign-id') + '/phone_calls';
    $.ajax({
      type: 'POST',
      url: url,
      beforeSend: function (xhr) {
        var csrfToken = $('meta[name="csrf-token"]').attr('content');
        xhr.setRequestHeader('X-CSRF-Token', csrfToken);
      },
      success: function (data, textStatus, jqXHR) {
        Twilio.Device.setup(data.twilio_token);
        Twilio.Device.connect({phone_call_id: data.phone_call_id});
      }
    });
  });
}
