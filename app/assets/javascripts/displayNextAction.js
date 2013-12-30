displayNextAction = function displayNextAction(element) {
  var $element = $(element);

  $element.click(function (event) {
    var $target = $(event.target);
    $target.hide();

    var $nextElement = $($target.data('next-selector'));
    $nextElement.show();

    event.preventDefault();
  });
}
