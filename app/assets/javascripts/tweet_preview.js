function tweetPreview($element) {
  var $preview = $('#tweet-preview');

  function updateText() {
    var text = $(this).val();
    $preview.text(text + ' t.co/rndm42')
  }

  $element.keydown(updateText);
  $element.keyup(updateText);
}
