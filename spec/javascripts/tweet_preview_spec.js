describe('tweetPreview', function () {
  var $fixture, $element, $preview;

  beforeEach(function () {
    $fixture = setFixture('<input data-behavior="tweetPreview"></input><div id="tweet-preview"></div>')
    $element = $fixture.find('input');
    $preview = $fixture.find('#tweet-preview');
    expect($preview.text()).toBeFalsy();
  });

  it("updates the text on key up", function () {
    $element.val('Foo Bar');

    $element.keydown();

    expect($preview.text()).toContain('Foo Bar');
  });

  it("updates the text on key down", function () {
    $element.val('Goo Bar');

    $element.keyup();

    expect($preview.text()).toContain('Goo Bar');
  });

  it("inserts a sample twitter url at the end of the text", function () {
    $element.val('Foo Bar Baz');

    $element.keyup();

    expect($preview.text()).toEqual('Foo Bar Baz t.co/rndm42');
  });
});
