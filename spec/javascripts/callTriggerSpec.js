describe("callTrigger", function () {
  var $fixture;

  describe("after the page loads", function () {
    beforeEach(function () {
      $fixture = setFixture('<a href="#" data-behavior="callTrigger">link</a>');
    });

    describe("on 'success'", function () {
      beforeEach(function () {
        spyOn(jQuery, 'ajax').and.callFake(function (options) {
          options.success({twilio_token: 'TwiML', phone_call_id: 42}, 'textStatus', 'jqXHR');
        });
      });

      it('connects with a Twilio Device', function () {
        spyOn(Twilio.Device, 'connect');

        $fixture.find('a').click();

        expect(Twilio.Device.connect).toHaveBeenCalledWith({phone_call_id: 42});
      });

      it('sets up a Twilio Device and calls', function () {
        spyOn(Twilio.Device, 'setup');

        $fixture.find('a').click();

        expect(Twilio.Device.setup).toHaveBeenCalledWith('TwiML');
      });
    });
  });

  describe("on page load", function () {
    beforeEach(function () {
      spyOn(jQuery, 'ajax').and.callFake(function (options) {
        options.success({twilio_token: 'TwiML', phone_call_id: 42}, 'textStatus', 'jqXHR');
      });
    });

    describe('when the trigger is set to true', function () {
      beforeEach(function () {
        setFixture('<a data-behavior="callTrigger" data-auto-trigger="true" id="element">Call</a>');
      });

      it('initiates a call', function () {
        spyOn(Twilio.Device, 'connect');

        Elemental.load();

        expect(Twilio.Device.connect).toHaveBeenCalledWith({phone_call_id: 42});
      });
    });

    describe('when the trigger is set to false', function () {
      beforeEach(function () {
        setFixture('<a data-behavior="callTrigger" data-auto-trigger="false" id="element">Call</a>');
      });

      it('does not initiate a call', function () {
        spyOn(Twilio.Device, 'connect');

        Elemental.load();

        expect(Twilio.Device.connect).not.toHaveBeenCalled();
      });
    });
  })
});
