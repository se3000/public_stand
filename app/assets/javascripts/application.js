// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require foundation
//= require turbolinks
//= require elemental
//= require public_stand
//= require swfobject
//= require wysihtml5
//= require wysihtml5-rules
//= require_tree .

jQuery(document).foundation()
  .foundation('reveal', {closeOnBackgroundClick: false});

$(document).ready(function() {
  Elemental.load(document);
  $('#ps-flash-grandparent').addClass('reveal-modal');

  mixpanel.track("page load", {url: window.location.toString()});

  $.dynatableSetup({dataset: {perPageDefault: 20}});
  $('.dynatable').dynatable();
});
