afterEach(function () {
  $('#jasmine_content').empty();
  $('#ps-flash-grandparent').remove();
  PublicStand.walkthrough = undefined;
});

setFixture = function setFixture(newFixture) {
  $jasmineContent = $('#jasmine_content')
  $jasmineContent.empty();
  $jasmineContent.html(newFixture);
  Elemental.load($jasmineContent);
  return $jasmineContent;
}

Twilio = {
  Device: {
    connect: function () {},
    disconnect: function () {},
    disconnectAll: function () {},
    setup: function () {},
    ready: function () {}
  }
}

mixpanel = {
  track: function () {}
};
