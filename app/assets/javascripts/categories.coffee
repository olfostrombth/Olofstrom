# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).on "click", "#step_toggle", ->
    $('.step_form').toggle('show');

$ ->
  $(document).on "click", "#examination_toggle", ->
    $('.examination_form').toggle('show');

$ ->
  $(document).on "click", "#comment_toggle", ->
    $('.comment_form').toggle('show');
    $('html, body').animate({scrollTop:$(document).height()}, 'slow');




