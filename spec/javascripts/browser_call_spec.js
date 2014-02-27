describe('BrowserCall', function () {
  var twilioToken = 'TwiML';
  var phoneCallID = 42;

  describe('#startCall', function () {
    var campaignID = 17;

    it('calls connectWithTwilio on success', function () {
      spyOn(BrowserCall, 'connectWithTwilio');
      spyOn(jQuery, 'ajax').and.callFake(function (options) {
        options.success({twilio_token: 'TwiML', phone_call_id: 42}, 'textStatus', 'jqXHR');
      });

      BrowserCall.startCall(campaignID);

      expect(BrowserCall.connectWithTwilio).toHaveBeenCalledWith({twilio_token: 'TwiML', phone_call_id: 42}, 'textStatus', 'jqXHR');
    });
  });

  describe('#connectWithTwilio', function () {
    beforeEach(function () {
      PublicStand.setWalkthrough('mobile');
    });

    it('connects with a Twilio Device', function () {
      spyOn(Twilio.Device, 'connect');

      BrowserCall.connectWithTwilio({phone_call_id: phoneCallID, twilio_token: twilioToken});

      expect(Twilio.Device.connect).toHaveBeenCalledWith({phone_call_id: 42});
    });

    it('sets up a Twilio Device and calls', function () {
      spyOn(Twilio.Device, 'setup');

      BrowserCall.connectWithTwilio({phone_call_id: phoneCallID, twilio_token: twilioToken});

      expect(Twilio.Device.setup).toHaveBeenCalledWith('TwiML');
    });

    it('sets up the callbacks for seting up a Twilio Device', function () {
      spyOn(PublicStand.walkthrough, 'displayInstructions');
      spyOn(Twilio.Device, 'ready').and.callFake(function (callback) {
        callback();
      });

      BrowserCall.connectWithTwilio({phone_call_id: phoneCallID, twilio_token: twilioToken});

      expect(PublicStand.walkthrough.displayInstructions).toHaveBeenCalled();
    });

    it('sets up the call backs for connecting to Twilio', function () {
      spyOn(PublicStand.walkthrough, 'displayNextStep');
      spyOn(Twilio.Device, 'connect').and.callFake(function (callback) {
        if (typeof(callback) == 'function') {
          callback();
        }
      });

      BrowserCall.connectWithTwilio({phone_call_id: phoneCallID, twilio_token: twilioToken});

      expect(PublicStand.walkthrough.displayNextStep).toHaveBeenCalled();
    });

    it('sets up the callbacks for seting up a Twilio Device', function () {
      spyOn(PublicStand.walkthrough, 'displayNextStep');
      spyOn(Twilio.Device, 'disconnect').and.callFake(function (callback) {
        callback();
      });

      BrowserCall.connectWithTwilio({phone_call_id: phoneCallID, twilio_token: twilioToken});

      expect(PublicStand.walkthrough.displayNextStep).toHaveBeenCalled();
    });
  });
});
