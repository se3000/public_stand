describe("hangUpTrigger", function () {
  var $fixture;

  describe('when the element is "enabled"', function () {
    beforeEach(function () {
      $fixture = setFixture('<a href="#" data-behavior="hangUpTrigger">link</a>');
    });

    it('connects through Twilio on click', function () {
      spyOn(Twilio.Device, 'disconnectAll')

      $fixture.find('a').click();

      expect(Twilio.Device.disconnectAll).toHaveBeenCalled();
    });
  });

  describe('when the element is "disabled"', function () {
    beforeEach(function () {
      $fixture = setFixture('<a href="#" class="disabled" data-behavior="hangUpTrigger">link</a>');
    });

    it('connects through Twilio on click', function () {
      spyOn(Twilio.Device, 'disconnectAll')

      $fixture.find('a').click();

      expect(Twilio.Device.disconnectAll).not.toHaveBeenCalled();
    });
  });
});
