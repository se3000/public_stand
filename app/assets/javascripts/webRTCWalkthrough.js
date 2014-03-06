PublicStand.webRTCWalkthrough = {
  start: function start(campaignID) {
    BrowserCall.startCall(campaignID);
  },

  displayInstructions: function displayInstructions() {
    $('#webrtc-instructions').foundation('reveal', 'open');
    this.displayArrow();
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
    } else if ($step2.is(':visible')) {
      $step2.hide();
      $instructions.find('.step-3').show();
    } else if ($step3.is(':visible')) {
      $step3.hide();
      $instructions.find('.step-4').show();
    }
  },

  displayArrow: function () {
    var $arrow = $('#webrtc-arrow');
    if (PublicStand.browserOS() == 'windows') {
      $arrow.css('left', '345px');
    } else {
      $arrow.css('right', '60px');
    }
    $arrow.show();
  }
}
