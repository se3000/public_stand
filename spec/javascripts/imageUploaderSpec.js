describe('imageUploader', function () {
  var $element, $button;

  beforeEach(function () {
    $fixture = setFixture('<form>\
      <input data-behavior="imageUploader" id="element"/>\
      <input type="submit" id="button"/>\
    </form>');
    $element = $('#element');
    $button = $('#button');
  });

  describe('after the input has been changed to have a file', function () {
    it("disables the form's submit button", function () {
      $button.removeAttr('disabled');
      expect($button.is(':disabled')).toBeFalsy();

      $element.val('').change();

      expect($button.is(':disabled')).toBeTruthy();
    });
  });

  describe('after the input has been changed not to have a file', function () {
    it("disables the form's submit button", function () {
      $button.attr('disabled', 'disabled');
      expect($button.is(':disabled')).toBeTruthy();

      $element.val('C:\\fakepath').change();

      expect($button.is(':disabled')).toBeFalsy();
    });
  });
});
