# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#step_toggle').click ->
    $('.step_form').toggle('show');

$ ->
  $('#comment_toggle').click ->
    $('.comment_form').toggle('show');
    $('html, body').animate({scrollTop:$(document).height()}, 'slow');

