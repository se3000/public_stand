describe('PublicStand.flashWalkthrough', function () {
  var walkthrough = PublicStand.flashWalkthrough;
  var $instructions, $step1, $step2, $step3;

  resetSteps = function () {
    $instructions = $('#ps-flash-grandparent');
    $step1 = $('#ps-flash-parent');
    $step2 = $('.step-2');
    $step3 = $('.step-3');
  }

  beforeEach(function () {
    setFixture("<div class='reveal-modal' id='ps-flash-grandparent' style='visibility: hidden;'>\
                 <div id='ps-flash-parent'/>\
               </div>\
               <div id='flash-instructions-container'>\
                 <div class='step-2'/>\
                 <div class='step-3'/>\
               </div>");
    $oldInstructions = $('#flash-instructions-container');
    resetSteps();
    $oldInstructions.children().andSelf().hide();
    $instructions.hide();
  });

  describe('#displayInstructions', function () {
    it('removes the Flash old instruction container', function () {
      expect($('#flash-instructions-container')[0]).toBeTruthy();

      walkthrough.displayInstructions();

      expect($('#flash-instructions-container')[0]).toBeFalsy();
      expect($instructions.children().length).toEqual(3)
    });
  });

  describe('#displayNextStep', function () {
    beforeEach(function () {
      walkthrough.displayInstructions();
      $instructions.show();
      $instructions.children().hide();
      resetSteps();
    });

    describe('when the first step is visible', function () {
      beforeEach(function () {
        $step1.show();
      });

      it('displays the second step', function () {
        expect($step1.is(':visible')).toBeTruthy();
        expect($step2.is(':visible')).toBeFalsy();
        expect($step3.is(':visible')).toBeFalsy();

        walkthrough.displayNextStep();

        expect($step1.is(':visible')).toBeFalsy();
        expect($step2.is(':visible')).toBeTruthy();
        expect($step3.is(':visible')).toBeFalsy();
      });
    });

    describe('when the second step is visible', function () {
      beforeEach(function () {
        $step2.show();
      });

      it('displays the third step', function () {
        expect($step1.is(':visible')).toBeFalsy();
        expect($step2.is(':visible')).toBeTruthy();
        expect($step3.is(':visible')).toBeFalsy();

        walkthrough.displayNextStep();

        expect($step1.is(':visible')).toBeFalsy();
        expect($step2.is(':visible')).toBeFalsy();
        expect($step3.is(':visible')).toBeTruthy();
      });
    });
  });
});
