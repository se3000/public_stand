function wysiwyg(element) {
  new wysihtml5.Editor("campaign_description", {
    toolbar:      "wysihtml5-toolbar",
    parserRules: wysihtml5ParserRules
  });
}
