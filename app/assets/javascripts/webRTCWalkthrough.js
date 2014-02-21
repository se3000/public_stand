PublicStand.webRTCWalkthrough = {
  displayInstructions: function () {
    var $instructions = $('#webrtc-instructions');
    var $step1 = $instructions.find('.step-1');

    $instructions.foundation('reveal', 'open');
    $instructions.show();
    $step1.show();
  },

  displayNextStep: function () {
    var $instructions = $('#webrtc-instructions');
    var $step1 = $instructions.find('.step-1');
    var $step2 = $instructions.find('.step-2');
    var $step3 = $instructions.find('.step-3');

    if ($step1.is(':visible')) {
      $step1.hide();
      $step2.show();
      $instructions.find('.hang-up-btn').removeClass('disabled');
    } else if ($step2.is(':visible')) {
      $step2.hide();
      $step3.show();
    }
  }
}
