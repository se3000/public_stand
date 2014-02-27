describe('PublicStand', function () {
  describe('#walkthrough', function () {
    describe("when set to mobile", function () {
      beforeEach(function () {
        PublicStand.setWalkthrough('mobile');
      });

      it("uses the mobile walkthrough", function () {
        expect(PublicStand.walkthrough).toEqual(PublicStand.mobileWalkthrough);
      });

      it('reveals mobile instructions', function () {
        spyOn(PublicStand.mobileWalkthrough, 'displayInstructions');

        PublicStand.displayInstructions();

        expect(PublicStand.mobileWalkthrough.displayInstructions).toHaveBeenCalled();
      });

      it('reveals the next mobile step', function () {
        spyOn(PublicStand.mobileWalkthrough, 'displayNextStep');

        PublicStand.displayNextStep();

        expect(PublicStand.mobileWalkthrough.displayNextStep).toHaveBeenCalled();
      });

      it('starts the mobile walkthrough', function () {
        spyOn(PublicStand.mobileWalkthrough, 'start');

        PublicStand.callCampaign(17);

        expect(PublicStand.mobileWalkthrough.start).toHaveBeenCalledWith(17);
      });
    });

    describe("when set to browser", function () {
      describe("and requires flash", function () {
        beforeEach(function () {
          spyOn(PublicStand, 'browserCapability').and.returnValue('flash')
          PublicStand.setWalkthrough('browser');
        });

        it("uses the flash walkthrough", function () {
          expect(PublicStand.walkthrough).toEqual(PublicStand.flashWalkthrough);
        });

        it('reveals Flash instructions', function () {
          spyOn(PublicStand.flashWalkthrough, 'displayInstructions');

          PublicStand.displayInstructions();

          expect(PublicStand.flashWalkthrough.displayInstructions).toHaveBeenCalled();
        });

        it('reveals the next Flash step', function () {
          spyOn(PublicStand.flashWalkthrough, 'displayNextStep');

          PublicStand.displayNextStep();

          expect(PublicStand.flashWalkthrough.displayNextStep).toHaveBeenCalled();
        });

        it('starts the flash walkthrough', function () {
          spyOn(PublicStand.flashWalkthrough, 'start');

          PublicStand.callCampaign(17);

          expect(PublicStand.flashWalkthrough.start).toHaveBeenCalledWith(17);
        });
      });

      describe("and uses webRTC", function () {
        beforeEach(function () {
          spyOn(PublicStand, 'browserCapability').and.returnValue('webRTC')
          PublicStand.setWalkthrough('browser');
        });

        it("uses the webRTC walkthrough", function () {
          expect(PublicStand.walkthrough).toEqual(PublicStand.webRTCWalkthrough);
        });

        it('reveals WebRTC instructions', function () {
          spyOn(PublicStand.webRTCWalkthrough, 'displayInstructions');

          PublicStand.displayInstructions();

          expect(PublicStand.webRTCWalkthrough.displayInstructions).toHaveBeenCalled();
        });

        it('reveals the next WebRTC step', function () {
          spyOn(PublicStand.webRTCWalkthrough, 'displayNextStep');

          PublicStand.displayNextStep();

          expect(PublicStand.webRTCWalkthrough.displayNextStep).toHaveBeenCalled();
        });

        it('starts the webRTC walkthrough', function () {
          spyOn(PublicStand.webRTCWalkthrough, 'start');

          PublicStand.callCampaign(17);

          expect(PublicStand.webRTCWalkthrough.start).toHaveBeenCalledWith(17);
        });
      });
    });
  });
});
