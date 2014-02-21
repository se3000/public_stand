PublicStand.flashWalkthrough = {
  displayInstructions: function () {
    var $instructions = $('#ps-flash-grandparent');
    var $oldInstructions = $('#flash-instructions-container');

    $oldInstructions.children().hide();
    $instructions.children().andSelf().removeAttr('style');
    $instructions.append($oldInstructions.html());
    $instructions.foundation('reveal', 'open');
    $instructions.find('.step-2, .step-3').hide();
    $oldInstructions.remove();
  },

  displayNextStep: function () {
    var $instructions = $('#ps-flash-grandparent');
    var $step1 = $instructions.find('#ps-flash-parent');
    var $step2 = $instructions.find('.step-2');
    var $step3 = $instructions.find('.step-3');

    if ($step1.is(':visible')) {
      $step1.hide();
      $step2.show();
    } else if ($step2.is(':visible')) {
      $step2.hide();
      $step3.show();
    }
  }
}
