describe("callTrigger", function () {
  var $fixture, $element;

  describe("after the page loads", function () {
    beforeEach(function () {
      $fixture = setFixture('<a href="#" data-behavior="callTrigger">link</a>');
      $element = $fixture.find('a');

      spyOn(jQuery, 'ajax').and.callFake(function (options) {
        options.success({twilio_token: 'TwiML', phone_call_id: 42}, 'textStatus', 'jqXHR');
      });
    });

    describe("on 'success'", function () {
      it('connects with a Twilio Device', function () {
        spyOn(Twilio.Device, 'connect');

        $element.click();

        expect(Twilio.Device.connect).toHaveBeenCalledWith({phone_call_id: 42});
      });

      it('sets up a Twilio Device and calls', function () {
        spyOn(Twilio.Device, 'setup');

        $element.click();

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
        $fixture = setFixture('<a data-behavior="callTrigger" data-auto-trigger="true" id="element">Call</a>');
        $element = $fixture.find('a').show();
      });

      it('initiates a call', function () {
        spyOn(Twilio.Device, 'connect');

        Elemental.load();

        expect(Twilio.Device.connect).toHaveBeenCalledWith({phone_call_id: 42});
      });

      it('hides the button', function () {
        expect($element.is(':visible')).toBeTruthy();

        Elemental.load();

        expect($element.is(':visible')).toBeFalsy();
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
