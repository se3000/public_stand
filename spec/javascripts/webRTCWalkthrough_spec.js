describe('PublicStand.webRTCWalkthrough', function () {
  var webRTC = PublicStand.webRTCWalkthrough;
  var $instructions, $step1, $step2, $step3, $arrow;

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

      webRTC.displayInstructions();

      expect($.fn.foundation).toHaveBeenCalledWith('reveal', 'open');
    });

    it('makes the webRTC arrow visible', function () {
      expect($arrow.is(":visible")).toBeFalsy();

      webRTC.displayInstructions();

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

        webRTC.displayNextStep();

        expect($step1.is(':visible')).toBeFalsy();
        expect($step2.is(':visible')).toBeTruthy();
        expect($step3.is(':visible')).toBeFalsy();
      });

      it('hides the webRTC arrow', function () {
        expect($arrow.is(":visible")).toBeTruthy();

        webRTC.displayNextStep();

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

        webRTC.displayNextStep();

        expect($step1.is(':visible')).toBeFalsy();
        expect($step2.is(':visible')).toBeFalsy();
        expect($step3.is(':visible')).toBeTruthy();
      });
    });
  });
});
