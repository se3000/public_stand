callTrigger = function callTrigger(element) {
  var $element = $(element);
  var campaignID = $element.data('campaign-id');

  function startCall() {
    PublicStand.displayInstructions();
    PublicStand.callCampaign(campaignID);
    $element.hide();
  }

  $element.click(startCall)

  if($element.data('auto-trigger')) {
    startCall();
  }
}
