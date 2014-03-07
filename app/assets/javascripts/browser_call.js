BrowserCall = {
  startCall: function startCall(campaignTargetID) {
    var url = '/campaign_targets/' + campaignTargetID + '/phone_calls';
    $.ajax({
      type: 'POST',
      url: url,
      beforeSend: function (xhr) {
        var csrfToken = $('meta[name="csrf-token"]').attr('content');
        xhr.setRequestHeader('X-CSRF-Token', csrfToken);
      },
      success: BrowserCall.connectWithTwilio
    });
  },

  connectWithTwilio: function connectWithTwilio(data, textStatus, jqXHR) {
    this.phoneCallID = data.phone_call_id;

    Twilio.Device.ready(PublicStand.displayInstructions);
    Twilio.Device.setup(data.twilio_token);

    Twilio.Device.connect(PublicStand.displayNextStep);
    Twilio.Device.connect({phone_call_id: data.phone_call_id});

    Twilio.Device.disconnect(PublicStand.hideCall);
  }
}
