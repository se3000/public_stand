describe('closeModal', function () {
  var $element

  describe('on click', function () {
    beforeEach(function () {
      setFixture('<div data-behavior="closeModal"/>');
      $element = $('div[data-behavior="closeModal"]');
    });

    it('closes the reveal modal', function () {
      spyOn($.fn, 'foundation');

      $element.click();

      expect($.fn.foundation).toHaveBeenCalled()//With('reveal', 'close');
    });
  });
});
