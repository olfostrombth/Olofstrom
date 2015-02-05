# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#quiz_toggle').click ->
    $('.quiz_form').toggle('show');
    $('html, body').animate({scrollTop:$(document).height()}, 'slow');
