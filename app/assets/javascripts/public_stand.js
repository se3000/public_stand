PublicStand = {
  browserCapability: function browserCapability() {
    if (navigator.userAgent.match(/Chrome/)) {
      return 'webRTC';
    } else {
      return 'flash';
    }
  },

  setWalkthrough: function setWalkthrough(type) {
    if (type === 'mobile') {
      this.walkthrough = PublicStand.mobileWalkthrough;
    } else if (PublicStand.browserCapability() === 'webRTC') {
      this.walkthrough = PublicStand.webRTCWalkthrough;
    } else {
      this.walkthrough = PublicStand.flashWalkthrough;
    }
    return this.walkthrough;
  },

  callCampaign: function callCampaign(campaignID) {
    this.walkthrough.start(campaignID);
  },

  displayInstructions: function displayInstructions() {
    PublicStand.walkthrough.displayInstructions();
  },

  displayNextStep: function displayNextStep() {
    PublicStand.walkthrough.displayNextStep();
  }
}
