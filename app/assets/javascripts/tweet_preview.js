function tweetPreview($element) {
  var $text = $('#tweet-text');
  var $backup = $('#backup-tweet-text');

  function updateText(input) {
    var previewText;
    if ($text.val())
      previewText = $text.val();
    else {
      previewText = $backup.val();
    }
    $element.text(previewText + ' http://t.co/abcxyz1234');
    var charCount = 118 - previewText.length;
    $('#letter-count-preview').text(charCount.toString() + '/140');
  }

  $text.keyup(updateText);
  $backup.keyup(updateText);
}
