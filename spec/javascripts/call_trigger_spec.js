describe("callTrigger", function () {
  var $fixture, $element;

  describe("after the page loads", function () {
    beforeEach(function () {
      $fixture = setFixture('<a href="#" data-behavior="callTrigger" data-campaign-id="3" data-call-type="tinCan">link</a>');
      $element = $fixture.find('a');
    });

    describe("on click", function () {
      it('initiates a call', function () {
        spyOn(PublicStand, 'callCampaign');

        $element.click();

        expect(PublicStand.callCampaign).toHaveBeenCalledWith(3);
      });

      it('sets the walkthrough type', function () {
        spyOn(PublicStand, 'callCampaign');
        spyOn(PublicStand, 'setWalkthrough');

        $element.click();

        expect(PublicStand.setWalkthrough).toHaveBeenCalledWith('tinCan');
      });
    });
  });

  describe("on page load", function () {
    describe('when the trigger is set to true', function () {
      beforeEach(function () {
        $fixture = setFixture('<a data-behavior="callTrigger" data-auto-trigger="true" data-campaign-id="3" id="element">Call</a>');
        $element = $fixture.find('a').show();
      });

      describe("and the button is visible", function () {
        beforeEach(function () { $element.show(); });

        it('initiates a call', function () {
          spyOn(PublicStand, 'callCampaign');

          Elemental.load();

          expect(PublicStand.callCampaign).toHaveBeenCalledWith(3);
        });
      });

      describe("and the button is NOT visible", function () {
        beforeEach(function () { $element.hide(); });

        it('initiates a call', function () {
          spyOn(PublicStand, 'callCampaign');

          Elemental.load();

          expect(PublicStand.callCampaign).not.toHaveBeenCalledWith(3);
        });
      });
    });

    describe('when the trigger is set to false', function () {
      beforeEach(function () {
        setFixture('<a data-behavior="callTrigger" data-auto-trigger="false" id="element">Call</a>');
      });

      it('does not initiate a call', function () {
        spyOn(PublicStand, 'callCampaign');

        Elemental.load();

        expect(PublicStand.callCampaign).not.toHaveBeenCalled();
      });
    });
  })
});
