# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  # hack: decorate Youtube iframes
  $('.nl-content-col.text.lb iframe').each ->
    $(this).wrap('<div class="img-place txa-c"><div class="deco-frame" /></div>')