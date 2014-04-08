closeModal = function closeModal($element) {
  $element.click(function (event) {
    $element.foundation('reveal', 'close');
  });
}
