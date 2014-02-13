callTrigger = function callTrigger(element) {
  var $element = $(element);
  var campaignID = $element.data('campaign-id');

  function startCall(event) {
    PublicStand.callCampaign(campaignID);
    PublicStand.displayInstructions();
    $element.hide();
  }

  $element.click(function (event) {
    startCall()
    event.preventDefault();
  });

  if($element.data('auto-trigger')) {
    startCall();
  }
}
