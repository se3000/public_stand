callTrigger = function callTrigger(element) {
  var $element = $(element);

  function startCall(event) {
    PublicStand.callCampaign($element.data('campaign-id'));
    $element.hide();
  }

  function setWalkthrough() {
    var callType = $element.data('call-type');
    if (callType === 'browser') {
      callType = PublicStand.browserCallType();
    }
    PublicStand.setWalkthrough(callType);
  }

  $element.click(function (event) {
    setWalkthrough();
    startCall();
    event.preventDefault();
  });

  if($element.data('auto-trigger')) {
    startCall();
  }
}
