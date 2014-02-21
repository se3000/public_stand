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
        Twilio.Device.ready(function () {
          PublicStand.displayInstructions();
        });
        Twilio.Device.connect(PublicStand.displayNextInstructions);
        Twilio.Device.connect({phone_call_id: data.phone_call_id});
      }
    });
  },

  displayInstructions: function () {
    var walkthrough = PublicStand.webRTCWalkthrough;
    if ($('#__connectionFlash__').length === 0) {
      walkthrough.displayInstructions();
    } else {
      var $container = $('#ps-flash-grandparent');
      $container.children().andSelf().removeAttr('style');
      $container.foundation('reveal', 'open');
    }
  },

  displayNextInstructions: function () {
    var walkthrough = PublicStand.webRTCWalkthrough
    walkthrough.displayNextStep();

    $('.hang-up-btn').removeClass('disabled');
  }
}
