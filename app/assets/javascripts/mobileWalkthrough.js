PublicStand.mobileWalkthrough = {
  displayInstructions: function displayInstructions() {
    $('#mobile-instructions').foundation('reveal', 'open');
    mixpanelTrack('walkthrough start', {type: 'mobile'});
  },

  displayNextStep: function displayNextStep() {
    var $instructions = $('#mobile-instructions');
    var $step1 = $instructions.find('.step-1');
    var $step2 = $instructions.find('.step-2');
    var $step3 = $instructions.find('.step-3');
    var $step4 = $instructions.find('.step-4');

    if ($step1.is(':visible')) {
      mixpanelTrack('call start', {type: 'mobile'});
      $step1.hide();
      $step2.show();
    } else if ($step2.is(':visible')) {
      $step2.hide();
      $step3.show();
      mixpanelTrack('gather feedback', {type: 'mobile'});
    } else if ($step3.is(':visible')) {
      $step3.hide();
      $step4.show();
      mixpanelTrack('social sharing', {type: 'mobile'});
    }
  },

  start: function start(campaignID) {
    this.displayInstructions();
  },

  hideCall: function hideCall() {}
}
