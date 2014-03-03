describe('tweetPreview', function () {
  var $fixture, $preview, $text, $backup;

  beforeEach(function () {
    $fixture = setFixture('<input id="tweet-text"></input><input id="backup-tweet-text"></input><div data-behavior="tweetPreview"></div>')
    $text = $fixture.find('#tweet-text');
    $backup = $fixture.find('#backup-tweet-text');
    $preview = $fixture.find('div[data-behavior="tweetPreview"]');
    expect($preview.text()).toBeFalsy();
  });

  it("inserts a sample twitter url at the end of the text on keyup", function () {
    $text.val('Foo Bar Baz');

    $text.keyup();

    expect($preview.text()).toEqual('Foo Bar Baz t.co/randomShortened42');
  });

  describe('updating the primary input', function () {
    describe("when there is a value to the primary input", function () {
      beforeEach(function () {
        $text.val('Foo Bar Baz').keyup();
      });

      it("inserts a sample twitter url at the end of the text on keyup", function () {
        $backup.val('backup text');

        $backup.keyup();

        expect($preview.text()).toEqual('Foo Bar Baz t.co/randomShortened42');
      });
    });

    describe("when there isn't a value to the primary input", function () {
      beforeEach(function () {
        $text.val(undefined);
      });

      it("inserts a sample on keyup", function () {
        $backup.val('backup text');

        $backup.keyup();

        expect($preview.text()).toEqual('backup text t.co/randomShortened42');
      });
    });
  });
});
