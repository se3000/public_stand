PublicStand = {
  browserCapability: function () {
    if (navigator.userAgent.match(/Chrome/)) {
      return 'webRTC';
    } else {
      return 'flash';
    }
  },

  setWalkthrough: function (type) {
    if (type === 'mobile') {
      this.walkthrough = PublicStand.mobileWalkthrough;
    } else if (PublicStand.browserCapability() === 'webRTC') {
      this.walkthrough = PublicStand.webRTCWalkthrough;
    } else {
      this.walkthrough = PublicStand.flashWalkthrough;
    }
    return this.walkthrough;
  },

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
        if (PublicStand.walkthrough === PublicStand.mobileWalkthrough) {
          PublicStand.displayInstructions();
        } else {
          Twilio.Device.ready(PublicStand.displayInstructions);
          Twilio.Device.setup(data.twilio_token);

          Twilio.Device.connect(PublicStand.displayNextStep);
          Twilio.Device.connect({phone_call_id: data.phone_call_id});
        }
      }
    });
  },

  displayInstructions: function() {
    PublicStand.walkthrough.displayInstructions();
  },

  displayNextStep: function() {
    PublicStand.walkthrough.displayNextStep();
  }
}
