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
  });

  describe('#displayInstructions', function () {
    describe('when the flash dialog exists', function () {
      beforeEach(function () {
        setFixture("<div id='ps-flash-grandparent'>1</div>");
      });

      it('reveals webRTC instructions', function () {
        spyOn($.fn, 'foundation');

        PublicStand.displayInstructions();

        expect($.fn.foundation).not.toHaveBeenCalledWith('reveal', 'open');
      });
    });

    describe('when the flash dialog does not exist', function () {
      beforeEach(function () {
        setFixture("<div id='null'>1</div>");
      });

      it('reveals webRTC instructions', function () {
        spyOn($.fn, 'foundation');

        PublicStand.displayInstructions();

        expect($.fn.foundation).toHaveBeenCalledWith('reveal', 'open');
      });
    });
  });
});
