PublicStand.webRTCWalkthrough = {
  start: function start(campaignID) {
    BrowserCall.startCall(campaignID);
    mixpanelTrack('call start', {type: 'webrtc'});
  },

  displayInstructions: function displayInstructions() {
    $('#webrtc-instructions').foundation('reveal', 'open');
    this.displayArrow();
    mixpanelTrack('walkthrough start', {type: 'webrtc'});
  },

  displayNextStep: function displayNextStep() {
    var $instructions = $('#webrtc-instructions');
    var $step1 = $instructions.find('.step-1');
    var $step2 = $instructions.find('.step-2');
    var $step3 = $instructions.find('.step-3');

    if ($step1.is(':visible')) {
      $step1.hide();
      $('#webrtc-arrow').hide();
      $step2.show();
      mixpanelTrack('call start', {type: 'webrtc'});
    } else if ($step2.is(':visible')) {
      this.hideCall();
    } else if ($step3.is(':visible')) {
      $step3.hide();
      $instructions.find('.step-4').show();
      mixpanelTrack('social sharing', {type: 'webrtc'});
    }
  },

  displayArrow: function () {
    if (PublicStand.chrome) {
      var $arrow = $('#webrtc-arrow');
      if (PublicStand.browserOS() == 'windows') {
        $arrow.css('left', '345px');
      } else {
        $arrow.css('right', '60px');
      }
      $arrow.show();
    }
  },

  hideCall: function hideCall() {
    var $step2 = $('#webrtc-instructions .step-2');
    if ($step2.is(':visible')) {
      $step2.hide();
      $('#webrtc-instructions .step-3').show();
      mixpanelTrack('gather feedback', {type: 'webrtc'});
    }
  }
}
