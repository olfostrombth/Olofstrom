# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.best_in_place').best_in_place()

$(document).ready ->
  $('#new_comment').submit (e) ->
    e.preventDefault()
    $.ajax
      url: $(this).attr('action')
      data: $(this).serialize()
      method: 'POST'
      success: ->
    return
  return