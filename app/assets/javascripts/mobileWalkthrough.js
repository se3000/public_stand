PublicStand.mobileWalkthrough = {
  displayInstructions: function () {
    $('#mobile-instructions').foundation('reveal', 'open');
  },

  displayNextStep: function () {
    // var $instructions = $('#webrtc-instructions');
    // var $step1 = $instructions.find('.step-1');
    // var $step2 = $instructions.find('.step-2');

    // if ($step1.is(':visible')) {
      // $step1.hide();
      // $step2.show();
    // } else if ($step2.is(':visible')) {
      // $step2.hide();
      // $instructions.find('.step-3').show();
    // }
  },

  start: function (campaignID) {
    this.displayInstructions();
  }
}
