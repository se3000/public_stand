describe('PublicStand.webRTCWalkthrough', function () {
  var walkthrough = PublicStand.webRTCWalkthrough;
  var $instructions, $step1, $step2, $step3, $arrow;

  describe('#start', function () {
    it('starts a call in the browser', function () {
      spyOn(BrowserCall, 'startCall');

      walkthrough.start(3);

      expect(BrowserCall.startCall).toHaveBeenCalledWith(3);
    });
  });

  describe('displaying the walkthrough', function () {
    beforeEach(function () {
      setFixture("<div class='reveal-modal' id='webrtc-instructions' style='visibility: hidden;'>\
                   <div class='step-1'/>\
                   <div class='step-2'/>\
                   <div class='step-3'/>\
                 </div>\
                 <div id='webrtc-arrow'\>");
      $instructions = $('#webrtc-instructions');
      $step1 = $('.step-1');
      $step2 = $('.step-2');
      $step3 = $('.step-3');
      $instructions.children().andSelf().hide();
      $arrow = $('#webrtc-arrow').hide();
    });

    describe('#displayInstructions', function () {
      it('reveals the first step of webRTC instructions', function () {
        spyOn($.fn, 'foundation').and.callFake(function () {
          expect(this[0].id).toEqual('webrtc-instructions');
        });

        walkthrough.displayInstructions();

        expect($.fn.foundation).toHaveBeenCalledWith('reveal', 'open');
      });

      it('makes the walkthrough arrow visible', function () {
        expect($arrow.is(":visible")).toBeFalsy();

        walkthrough.displayInstructions();

        expect($arrow.is(":visible")).toBeTruthy();
      });
    });

    describe('#displayNextStep', function () {
      beforeEach(function () {
        $instructions.show();
      });

      describe('when the first step is visible', function () {
        beforeEach(function () {
          $step1.show();
          $arrow.show();
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

        it('hides the walkthrough arrow', function () {
          expect($arrow.is(":visible")).toBeTruthy();

          walkthrough.displayNextStep();

          expect($arrow.is(":visible")).toBeFalsy();
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
});
