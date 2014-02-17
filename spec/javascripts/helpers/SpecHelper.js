afterEach(function () {
  $('#jasmine_content').empty();
  $('#ps-flash-grandparent').remove();
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
    connect: function() {},
    disconnectAll: function() {},
    setup: function() {},
    ready: function() {}
  }
}
