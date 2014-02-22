callTrigger = function callTrigger(element) {
  var $element = $(element);

  function startCall(event) {
    PublicStand.callCampaign($element.data('campaign-id'));
    $element.hide();
  }

  function setWalkthrough() {
  }

  $element.click(function (event) {
    PublicStand.setWalkthrough($element.data('call-type'));
    startCall();
    event.preventDefault();
  });

  if($element.data('auto-trigger')) {
    PublicStand.setWalkthrough($element.data('call-type'));
    startCall();
  }
}
