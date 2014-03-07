walkthroughFeedback = function walkthroughFeedback($element) {
  $element.submit(function (event) {
    var $this = $(this);
    var url = '/phone_calls/' + $this.data('phone-call-id') + '/phone_call_feedback'
    $.ajax({
      type: 'POST',
      data: $this.serialize(),
      url: url,
      success: PublicStand.displayNextStep
    });
    return false;
  });
}
