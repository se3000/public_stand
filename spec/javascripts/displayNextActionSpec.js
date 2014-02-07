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

    it("hides itself on click", function () {
      expect($element.is(':visible')).toBeTruthy();

      $element.click();

      expect($element.is(':visible')).toBeFalsy();
    });

    it("displays the next-selector on click", function () {
      expect($nextElement.is(':visible')).toBeFalsy();

      $element.click();

      expect($nextElement.is(':visible')).toBeTruthy();
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

    it("hides itself on click", function () {
      expect($element.is(':visible')).toBeTruthy();

      $element.click();

      expect($element.is(':visible')).toBeTruthy();
    });

    it("displays the next-selector on click", function () {
      expect($nextElement.is(':visible')).toBeFalsy();

      $element.click();

      expect($nextElement.is(':visible')).toBeFalsy();
    });
  });
});
