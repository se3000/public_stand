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
        Twilio.Device.ready(PublicStand.displayInstructions);
        Twilio.Device.setup(data.twilio_token);

        Twilio.Device.connect(PublicStand.displayNextStep);
        Twilio.Device.connect({phone_call_id: data.phone_call_id});
      }
    });
  },

  displayInstructions: function() {
    PublicStand.getWalkthrough().displayInstructions();
  },

  displayNextStep: function() {
    PublicStand.getWalkthrough().displayNextStep();
  },

  getWalkthrough: function () {
    if (this.walkthrough)
      return this.walkthrough;

    if ($('#__connectionFlash__').length === 0) {
      this.walkthrough = PublicStand.webRTCWalkthrough;
    } else {
      this.walkthrough = PublicStand.flashWalkthrough;
    }
    return this.walkthrough;
  }
}
