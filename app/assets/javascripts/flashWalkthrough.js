PublicStand.flashWalkthrough = {
  start: function start(campaignID) {
    BrowserCall.startCall(campaignID);
  },

  displayInstructions: function displayInstructions() {
    $('#ps-flash-grandparent').foundation('reveal', 'open');
  },

  displayNextStep: function displayNextStep() {
    var $oldInstructions = $('#ps-flash-grandparent');
    var $instructions = $('#flash-instructions');
    var $step2 = $instructions.find('.step-2');

    if (! $oldInstructions.hasClass('completed')) {
      $instructions.foundation('reveal', 'open');
      $oldInstructions.addClass('completed'); //FIXME: Hiding seems to break the Twilio Flash
    } else if ($step2.is(':visible')) {
      $step2.hide();
      $instructions.find('.step-3').show();
    }
  }
}
