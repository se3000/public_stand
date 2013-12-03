beforeEach(function () {
  jasmine.addMatchers({
    toBePlaying: function () {
      return {
        compare: function (actual, expected) {
          var player = actual;

          return {
            pass: player.currentlyPlayingSong === expected && player.isPlaying
          }
        }
      };
    }
  });
});

afterEach(function () {
  $('#jasmine_content').empty();
});

setFixture = function setFixture(newFixture) {
  jasmineContent = $('#jasmine_content')
  jasmineContent.empty();
  jasmineContent.html(newFixture);
  Elemental.load(jasmineContent);
  return jasmineContent;
}

Twilio = {
  Device: {
    setup: function() {}
  }
}
