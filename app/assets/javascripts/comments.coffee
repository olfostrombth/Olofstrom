# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.best_in_place').best_in_place()

$(document).ready ->
  $('.new_comment').bind 'ajax:complete', (event, xhr, status) ->
    #$(this).hide()
    #return document.getElementsByClassName('new_comment').reset()
    #$('.new_comment')[0].reset()
    $('.new_comment').trigger("reset")