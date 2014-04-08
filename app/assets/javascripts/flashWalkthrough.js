PublicStand.flashWalkthrough = {
  start: function start(campaignID) {
    if (this.upToDate()) {
      BrowserCall.startCall(campaignID);
    } else {
      $('#flash-alternative-instructions').foundation('reveal', 'open');
      mixpanelTrack('update flash');
    }
  },

  displayInstructions: function displayInstructions() {
    $('#ps-flash-grandparent').foundation('reveal', 'open');
    mixpanelTrack('walkthrough start', {type: 'flash'});
  },

  displayNextStep: function displayNextStep() {
    var $oldInstructions = $('#ps-flash-grandparent');
    var $instructions = $('#flash-instructions');
    var $step2 = $instructions.find('.step-2');
    var $step3 = $instructions.find('.step-3');
    var $step4 = $instructions.find('.step-4');

    if (! $oldInstructions.hasClass('completed')) {
      $instructions.foundation('reveal', 'open');
      $oldInstructions.addClass('completed'); //FIXME: Hiding seems to break the Twilio Flash
      mixpanelTrack('call start', {type: 'flash'});
    } else if ($step2.is(':visible')) {
      this.hideCall();
    } else if ($step3.is(':visible')) {
      $step3.hide();
      $step4.show();
      mixpanelTrack('social sharing', {type: 'flash'});
    }
  },

  hideCall: function hideCall() {
    var $step2 = $('#flash-instructions .step-2');
    if ($step2.is(':visible')) {
      $step2.hide();
      $('#flash-instructions .step-3').show();
      mixpanelTrack('gather feedback', {type: 'flash'});
    }
  },

  flashRequirements: {
    major: 10,
    minor: 1
  },

  upToDate: function upToDate() {
    version = swfobject.getFlashPlayerVersion();
    required = this.flashRequirements;
    if (version.major < required.major) {
      return false;
    } else if (version.major === required.major && version.minor < required.minor) {
      return false;
    } else {
      return true
    }
  }
}
