describe("hangUpTrigger", function () {
  var $fixture;

  beforeEach(function () {
    $fixture = setFixture('<a href="#" data-behavior="hangUpTrigger">link</a>');
  });

  it('connects through Twilio on click', function () {
    spyOn(Twilio.Device, 'disconnectAll')

    $fixture.find('a').click();

    expect(Twilio.Device.disconnectAll).toHaveBeenCalled();
  });
});
