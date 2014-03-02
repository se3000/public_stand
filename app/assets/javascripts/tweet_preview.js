function tweetPreview($element) {
  var $text = $('#tweet-text');
  var $backup = $('#backup-tweet-text');

  function updateText(input) {
    if ($text.val())
      $element.text($text.val() + ' t.co/rndm42')
    else {
      $element.text($backup.val() + ' t.co/rndm42')
    }
  }

  $text.keyup(updateText);
  $backup.keyup(updateText);
}
