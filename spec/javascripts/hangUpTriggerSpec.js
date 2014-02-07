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

    it('hides the reveal modal', function () {
      spyOn(jQuery.fn, 'foundation')

      $fixture.find('a').click();

      expect(jQuery.fn.foundation).toHaveBeenCalledWith('reveal', 'close');
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

    it('hides the reveal modal', function () {
      spyOn(jQuery.fn, 'foundation')

      $fixture.find('a').click();

      expect(jQuery.fn.foundation).not.toHaveBeenCalled();
    });
  });
});
