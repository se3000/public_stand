PublicStand.flashWalkthrough = {
  displayInstructions: function () {
    $('#ps-flash-grandparent').foundation('reveal', 'open');
  },

  displayNextStep: function () {
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
