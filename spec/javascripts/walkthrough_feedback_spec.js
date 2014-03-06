describe('walkthroughFeedback', function () {
  var $fixture, $form;

  beforeEach(function () {
    $fixture = setFixture('<form data-behavior="walkthroughFeedback" data-phone-call-id="1248">1</form>');
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

    it('posts to the correct url', function () {
      BrowserCall.phoneCallID = 1248;

      spyOn(jQuery, 'ajax').and.callFake(function (options) {
        expect(options.url).toEqual('/phone_calls/1248/phone_call_feedback');
      });

      $form.submit();
    });
  });
});
