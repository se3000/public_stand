describe("callTrigger", function () {
  var $fixture;

  beforeEach(function () {
    $fixture = setFixture('<a href="#" data-behavior="callTrigger">link</a>');
  });

  it('runs', function () {
    spyOn(Twilio.Device, 'setup')

    $fixture.find('a').click();

    expect(Twilio.Device.setup).toHaveBeenCalled();
  });
});
