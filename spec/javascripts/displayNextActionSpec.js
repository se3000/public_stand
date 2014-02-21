describe("displayNextAction", function () {
  var $fixture, $element;

  describe('on a "non-disabled" element', function () {
    beforeEach(function () {
      var fixture = "<a data-behavior='displayNextAction' data-next-selector='#next-link'>link</a>" +
        "<a id='next-link' hidden='hidden'>next link</a>";
      $fixture = setFixture(fixture);
      $element = $fixture.find('a[data-behavior="displayNextAction"]');
      $nextElement = $fixture.find('#next-link');
    });

    it("calls displayNextStep on PublicStand", function () {
      spyOn(PublicStand, 'displayNextStep');

      $element.click();

      expect(PublicStand.displayNextStep).toHaveBeenCalled();
    });
  });

  describe('when the element is marked as disabled', function () {
    beforeEach(function () {
      var fixture = "<a class='disabled' data-behavior='displayNextAction' data-next-selector='#next-link'>link</a>" +
        "<a id='next-link' hidden='hidden'>next link</a>";
      $fixture = setFixture(fixture);
      $element = $fixture.find('a[data-behavior="displayNextAction"]');
      $nextElement = $fixture.find('#next-link');
    });

    it("does not call displayNextStep on PublicStand", function () {
      spyOn(PublicStand, 'displayNextStep');

      $element.click();

      expect(PublicStand.displayNextStep).not.toHaveBeenCalled();
    });
  });
});
