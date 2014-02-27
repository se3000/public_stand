describe('startMobileCall', function () {
  var $fixture, $form;

  beforeEach(function () {
    $fixture = setFixture('<form data-behavior="startMobileCall">1</form>');
    $form = $fixture.find('form');
  });

  describe('on success', function () {
    it('displays the next step', function () {
      spyOn(jQuery, 'ajax').and.callFake(function (options) {
        options.success({}, 'textStatus', 'jqXHR');
      });
      spyOn(PublicStand, 'displayNextStep');

      $form.submit();

      expect(PublicStand.displayNextStep).toHaveBeenCalled();
    });
  });
});
