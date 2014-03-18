PublicStand.mobileWalkthrough = {
  displayInstructions: function displayInstructions() {
    $('#mobile-instructions').foundation('reveal', 'open');
    mixpanelTrack('walkthrough start', {type: 'mobile'});
  },

  displayNextStep: function displayNextStep() {
    var $instructions = $('#mobile-instructions');
    var $step1 = $instructions.find('.step-1');
    var $step2 = $instructions.find('.step-2');

    if ($step1.is(':visible')) {
      mixpanelTrack('call start', {type: 'mobile'});
      $step1.hide();
      $step2.show();
    }
  },

  start: function start(campaignID) {
    this.displayInstructions();
  },

  hideCall: function hideCall() {}
}
