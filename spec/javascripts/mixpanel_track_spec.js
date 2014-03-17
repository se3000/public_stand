describe('mixpanelTrack', function () {
  var options = {foo: 'bar'};
  var eventName = 'event name'

  it('call mixpanel.track', function () {
    spyOn(mixpanel, 'track');

    mixpanelTrack(eventName, options);

    expect(mixpanel.track).toHaveBeenCalledWith(eventName, options);
  });
})
