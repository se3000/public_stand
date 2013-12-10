afterEach(function () {
  $('#jasmine_content').empty();
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
    setup: function() {}
  }
}
