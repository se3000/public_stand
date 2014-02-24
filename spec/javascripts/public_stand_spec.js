describe('PublicStand', function () {
  describe('#callCampaign', function () {
    var campaignID = 17;

    beforeEach(function () {
      setFixture("<div class='step-1'>1</div><div hidden='hidden' class='step-2'>2</div><div class='hang-up-btn disabled'>3</div>");
      spyOn(jQuery, 'ajax').and.callFake(function (options) {
        options.success({twilio_token: 'TwiML', phone_call_id: 42}, 'textStatus', 'jqXHR');
      });
    });

    it('connects with a Twilio Device', function () {
      spyOn(Twilio.Device, 'connect');

      PublicStand.callCampaign(campaignID);

      expect(Twilio.Device.connect).toHaveBeenCalledWith({phone_call_id: 42});
    });

    it('sets up a Twilio Device and calls', function () {
      spyOn(Twilio.Device, 'setup');

      PublicStand.callCampaign(campaignID);

      expect(Twilio.Device.setup).toHaveBeenCalledWith('TwiML');
    });

    xit('hides anything with the class "step-1"', function () {
      expect($('.step-1').is(':visible')).toBeTruthy();

      PublicStand.callCampaign(campaignID);
      Twilio.Device.connect();

      expect($('.step-1').is(':visible')).toBeFalsy();
    });

    xit('displays anything with the class "step-2"', function () {
      expect($('.step-2').is(':visible')).toBeFalsy();

      PublicStand.callCampaign(campaignID);
      Twilio.Device.connect();

      expect($('.step-2').is(':visible')).toBeTruthy();
    });

    it('displays instructions when the device is ready', function () {
      spyOn(PublicStand, 'displayInstructions');

      spyOn(Twilio.Device, 'ready').and.callFake(function (callback) {
        callback();
      });
      PublicStand.callCampaign(campaignID);

      expect(PublicStand.displayInstructions).toHaveBeenCalled();
    });
  });

  describe('#walkthrough', function () {
    describe("when set to mobile", function () {
      beforeEach(function () {
        PublicStand.setWalkthrough('mobile');
      });

      it("uses the mobile walkthrough", function () {
        expect(PublicStand.walkthrough).toEqual(PublicStand.mobileWalkthrough);
      });

      xit('reveals WebRTC instructions', function () {
        spyOn(PublicStand.webRTCWalkthrough, 'displayInstructions');

        PublicStand.displayInstructions();

        expect(PublicStand.mobileWalkthrough.displayInstructions).toHaveBeenCalled();
      });

      xit('reveals the next WebRTC step', function () {
        spyOn(PublicStand.webRTCWalkthrough, 'displayNextStep');

        PublicStand.displayNextStep();

        expect(PublicStand.mobileWalkthrough.displayNextStep).toHaveBeenCalled();
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
      });
    });
  });
});
