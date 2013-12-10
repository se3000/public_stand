describe("callTrigger", function () {
  describe("after page load", function () {
    var $fixture;

    beforeEach(function () {
      $fixture = setFixture('<a href="#" data-behavior="callTrigger">link</a>');
    });

    it('connects through Twilio on click', function () {
      spyOn(Twilio.Device, 'connect')

      $fixture.find('a').click();

      expect(Twilio.Device.connect).toHaveBeenCalled();
    });
  });

  describe("on page load", function () {
    it('sets up the Twilio device', function () {
      spyOn(Twilio.Device, 'setup');

      var link = '<a href="#" data-behavior="callTrigger" data-token="twilioToken">link</a>'
      Elemental.load($('#jasmine_content').html(link));

      expect(Twilio.Device.setup).toHaveBeenCalledWith("twilioToken");
    });
  });
});
