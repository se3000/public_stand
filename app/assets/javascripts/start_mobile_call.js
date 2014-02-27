startMobileCall = function startMobileCall($element) {
  $element.submit(function (event) {
    var $this = $(this);
    $.ajax({
      type: 'POST',
      data: $this.serialize(),
      url: $this.attr('action'),
      success: PublicStand.displayNextStep
    });
    return false;
  });
}
