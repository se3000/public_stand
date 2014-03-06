walkthroughFeedback = function walkthroughFeedback($element) {
  $element.submit(function (event) {
    var $this = $(this);
    var url = '/phone_calls/' + BrowserCall.phoneCallID + '/phone_call_feedback'
    $.ajax({
      type: 'POST',
      data: $this.serialize(),
      url: url,
      success: PublicStand.displayNextStep
    });
    return false;
  });
}
