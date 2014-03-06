displayNextStep = function displayNextStep(element) {
  var $element = $(element);

  $element.click(function (event) {
    if (! $element.hasClass('disabled')) {
      PublicStand.displayNextStep();
    }
  });
}
