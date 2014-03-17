describe('mixpanelTrack', function () {
  var options = {foo: 'bar'};
  var eventName = 'event name'

  beforeEach(function () {
    mixpanel = {track: function () {}};
  });

  it('call mixpanel.track', function () {
    spyOn(mixpanel, 'track');

    mixpanelTrack(eventName, options);

    expect(mixpanel.track).toHaveBeenCalledWith(eventName, options);
  });
})
