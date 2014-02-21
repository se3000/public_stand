PublicStand = {
  callCampaign: function callCampaign(campaignID) {
    var url = '/campaigns/' + campaignID + '/phone_calls';
    $.ajax({
      type: 'POST',
      url: url,
      beforeSend: function (xhr) {
        var csrfToken = $('meta[name="csrf-token"]').attr('content');
        xhr.setRequestHeader('X-CSRF-Token', csrfToken);
      },
      success: function (data, textStatus, jqXHR) {
        Twilio.Device.setup(data.twilio_token);
        Twilio.Device.ready(PublicStand.displayInstructions);
        Twilio.Device.connect(function () {
          var $instruction = $('#instruction');
          $('.step-1').hide();
          $('.step-2').show();
          $('.hang-up-btn').removeClass('disabled');
        });
        Twilio.Device.connect({phone_call_id: data.phone_call_id});
      }
    });
  },

  displayInstructions: function() {
    if ($('#__connectionFlash__').length === 0) {
      $('#instruction').foundation('reveal', 'open');
    } else {
      var $container = $('#ps-flash-grandparent');
      $container.children().andSelf().removeAttr('style');
      $container.foundation('reveal', 'open');
    }
  }
}
