describe('PublicStand.flashWalkthrough', function () {
  var walkthrough = PublicStand.flashWalkthrough;
  var $instructions, $step1, $step2, $step3;

  describe('#start', function () {
    describe('when the flash player is up to date', function () {
      beforeEach(function () {
        spyOn(swfobject, 'getFlashPlayerVersion').and.returnValue({major: 10, minor: 1});
      });

      it('starts a call in the browser', function () {
        spyOn(BrowserCall, 'startCall');

        walkthrough.start(3);

        expect(BrowserCall.startCall).toHaveBeenCalledWith(3);
      });
    });

    describe('when the flash player is out of date', function () {
      beforeEach(function () {
        setFixture('<div id="flash-alternative-instructions"/>');
        spyOn(swfobject, 'getFlashPlayerVersion').and.returnValue({major: 10, minor: 0});
      });

      it('reveals the flash alternative directions', function () {
        spyOn($.fn, 'foundation').and.callFake(function () {
          expect(this[0].id).toEqual("flash-alternative-instructions");
        });

        walkthrough.start(3);

        expect($.fn.foundation).toHaveBeenCalledWith('reveal', 'open');
      });
    });
  });

  describe('displaying the steps', function () {
    resetSteps = function () {
      $oldInstructions = $('#ps-flash-grandparent');
      $instructions = $('#flash-instructions');
      $step1 = $('#ps-flash-parent');
      $step2 = $('.step-2');
      $step3 = $('.step-3');
      $step4 = $('.step-4');
    }

    beforeEach(function () {
      setFixture("<div class='reveal-modal' id='ps-flash-grandparent' style='visibility: hidden;'>\
                   <div id='ps-flash-parent'/>\
                 </div>\
                 <div id='flash-instructions'>\
                   <div class='step-2'/>\
                   <div class='step-3' hidden='hidden'/>\
                   <div class='step-4' hidden='hidden'/>\
                 </div>");
      resetSteps();
      $instructions.hide();
    });

    describe('#displayInstructions', function () {
      it('reveals the first set of flash instructions', function () {
        spyOn($.fn, 'foundation').and.callFake(function () {
          expect(this[0].id).toEqual("ps-flash-grandparent");
        });

        walkthrough.displayInstructions();

        expect($.fn.foundation).toHaveBeenCalledWith('reveal', 'open');
      });
    });

    describe('#displayNextStep', function () {
      beforeEach(function () {
        walkthrough.displayInstructions();
        resetSteps();
      });

      describe('when the first step is not completed', function () {
        beforeEach(function () {
          $oldInstructions.removeClass('completed');
        });

        it('displays the second step', function () {
          expect($oldInstructions.hasClass('completed')).toBeFalsy();

          walkthrough.displayNextStep();

          expect($oldInstructions.hasClass('completed')).toBeTruthy();
        });

        it('reveals the second set of flash instructions', function () {
          spyOn($.fn, 'foundation').and.callFake(function () {
            expect(this[0].id).toEqual('flash-instructions');
          });

          walkthrough.displayNextStep();

          expect($.fn.foundation).toHaveBeenCalledWith('reveal', 'open');
        });
      });

      describe('when the second step is visible', function () {
        beforeEach(function () {
          $instructions.show();
          $oldInstructions.addClass('completed');
        });

        it('calls hideCall', function () {
          spyOn(walkthrough, 'hideCall');

          walkthrough.displayNextStep();

          expect(walkthrough.hideCall).toHaveBeenCalled();
        });
      });

      describe('when the third step is visible', function () {
        beforeEach(function () {
          $instructions.show();
          $step2.hide();
          $step3.show();
          $oldInstructions.addClass('completed');
        });

        it('displays the third step', function () {
          expect($step3.is(':visible')).toBeTruthy();
          expect($step4.is(':visible')).toBeFalsy();

          walkthrough.displayNextStep();

          expect($step3.is(':visible')).toBeFalsy();
          expect($step4.is(':visible')).toBeTruthy();
        });
      });
    });
  });

  describe('.hideCall', function () {
    var $step2, $step3;

    beforeEach(function () {
      setFixture("<div id='flash-instructions'><div class='step-2'/><div class='step-3'/></div>");
      $step2 = $('.step-2').show();
      $step3 = $('.step-3').hide();
    });

    it('displays the third step', function () {
      expect($step2.is(':visible')).toBeTruthy();
      expect($step3.is(':visible')).toBeFalsy();

      walkthrough.hideCall();

      expect($step2.is(':visible')).toBeFalsy();
      expect($step3.is(':visible')).toBeTruthy();
    });
  });
});
