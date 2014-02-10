displayNextAction = function displayNextAction(element) {
  var $element = $(element);

  $element.click(function (event) {
    if (! $element.hasClass('disabled')) {
      var $target = $(event.target);
      $target.hide();

      $($target.data('next-selector')).show();
    }
  });
}
