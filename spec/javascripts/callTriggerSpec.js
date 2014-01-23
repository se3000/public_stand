describe("callTrigger", function () {
  var $fixture;

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
