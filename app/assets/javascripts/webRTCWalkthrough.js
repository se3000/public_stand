PublicStand.webRTCWalkthrough = {
  start: function start(campaignID) {
    BrowserCall.startCall(campaignID);
  },

  displayInstructions: function displayInstructions() {
    $('#webrtc-instructions').foundation('reveal', 'open');
    $('#webrtc-arrow').show();
  },

  displayNextStep: function displayNextStep() {
    var $instructions = $('#webrtc-instructions');
    var $step1 = $instructions.find('.step-1');
    var $step2 = $instructions.find('.step-2');

    if ($step1.is(':visible')) {
      $step1.hide();
      $('#webrtc-arrow').hide();
      $step2.show();
    } else if ($step2.is(':visible')) {
      $step2.hide();
      $instructions.find('.step-3').show();
    }
  }
}
