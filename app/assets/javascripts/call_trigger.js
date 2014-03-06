callTrigger = function callTrigger(element) {
  var $element = $(element);

  function startCall(event) {
    PublicStand.setWalkthrough($element.data('call-type'));
    PublicStand.callCampaign($element.data('campaign-target-id'));
  }

  $element.click(function (event) {
    startCall();
    event.preventDefault();
  });

  if($element.data('auto-trigger') && $element.is(':visible')) {
    startCall();
  }
}
