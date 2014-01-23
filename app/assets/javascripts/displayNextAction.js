displayNextAction = function displayNextAction(element) {
  var $element = $(element);

  $element.click(function (event) {
    var $target = $(event.target);
    $target.hide();

    $($target.data('next-selector')).show();
  });
}
