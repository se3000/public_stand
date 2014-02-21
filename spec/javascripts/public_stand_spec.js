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

  describe('#displayInstructions', function () {
    describe('when the flash object exists', function () {
      var grandparent, parent;

      beforeEach(function () {
        setFixture("<div id='ps-flash-grandparent' style='margin: 0;'>" +
                     "<div style='margin: 0;'>" +
                       "<object id='__connectionFlash__'>1</object>" +
                     "</div>" +
                   "</div>");
        grandparent = $('#ps-flash-grandparent');
        parent = grandparent.find('div');
      });

      it('reveals Flash instructions', function () {
        spyOn(PublicStand.flashWalkthrough, 'displayInstructions');

        PublicStand.displayInstructions();

        expect(PublicStand.flashWalkthrough.displayInstructions).toHaveBeenCalled();
      });
    });

    describe('when the flash dialog does not exist', function () {
      beforeEach(function () {
        setFixture("<div id='null'>1</div>");
      });

      it('reveals WebRTC instructions', function () {
        spyOn(PublicStand.webRTCWalkthrough, 'displayInstructions');

        PublicStand.displayInstructions();

        expect(PublicStand.webRTCWalkthrough.displayInstructions).toHaveBeenCalled();
      });
    });
  });

  describe('#displayNextStep', function () {
    describe('when the flash object exists', function () {
      var grandparent, parent;

      beforeEach(function () {
        setFixture("<div id='ps-flash-grandparent' style='margin: 0;'>" +
                     "<div style='margin: 0;'>" +
                       "<object id='__connectionFlash__'>1</object>" +
                     "</div>" +
                   "</div>");
        grandparent = $('#ps-flash-grandparent');
        parent = grandparent.find('div');
      });

      it('reveals the next Flash step', function () {
        spyOn(PublicStand.flashWalkthrough, 'displayNextStep');

        PublicStand.displayNextStep();

        expect(PublicStand.flashWalkthrough.displayNextStep).toHaveBeenCalled();
      });
    });

    describe('when the flash dialog does not exist', function () {
      beforeEach(function () {
        setFixture("<div id='null'>1</div>");
      });

      it('reveals the next WebRTC step', function () {
        spyOn(PublicStand.webRTCWalkthrough, 'displayNextStep');

        PublicStand.displayNextStep();

        expect(PublicStand.webRTCWalkthrough.displayNextStep).toHaveBeenCalled();
      });
    });
  });

  describe('#setWalkthrough', function () {
    describe("when given 'flash'", function () {
      beforeEach(function () {
        PublicStand.setWalkthrough('flash');
      });

      it("uses the mobile walkthrough", function () {
        expect(PublicStand.walkthrough).toEqual(PublicStand.flashWalkthrough);
      });
    });

    describe("when given 'mobile'", function () {
      beforeEach(function () {
        PublicStand.setWalkthrough('mobile');
      });

      it("uses the mobile walkthrough", function () {
        expect(PublicStand.walkthrough).toEqual(PublicStand.mobileWalkthrough);
      });
    });

    describe("when given 'webRTC'", function () {
      beforeEach(function () {
        PublicStand.setWalkthrough('webRTC');
      });

      it("uses the mobile walkthrough", function () {
        expect(PublicStand.walkthrough).toEqual(PublicStand.webRTCWalkthrough);
      });
    });
  });
});
