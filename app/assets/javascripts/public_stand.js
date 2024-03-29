PublicStand = {
  chrome: (!! navigator.userAgent.match(/Chrome/)),
  firefox: (!! navigator.userAgent.match(/Firefox/)),

  browserCapability: function browserCapability() {
    if (PublicStand.chrome || PublicStand.firefox) {
      return 'webRTC';
    } else {
      return 'flash';
    }
  },

  browserOS: function () {
    if (navigator.userAgent.match(/Windows/)) {
      return 'windows';
    } else {
      return 'unix';
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
  },

  hideCall: function () {
    PublicStand.walkthrough.hideCall();
  }
}
