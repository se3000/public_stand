function imageUploader($element) {
  var $form = $element.closest('form');
  var $button = $form.find('input[type="submit"]');

  $element.change(function (event) {
    if($element.val()) {
      $button.removeAttr('disabled');
    } else {
      $button.attr('disabled', 'disabled');
    }
  });
}
