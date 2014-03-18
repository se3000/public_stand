mixpanelTrack = function mixpanelTrack(name, options) {
  var newOptions = $.extend(options, {url: window.location.toString()});
  mixpanel.track(name, newOptions);
}
