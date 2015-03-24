# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on "click", "#send_examination", ->
  category_name = gon.catname
  step_name = gon.stepname
  completion = gon.completion
  $.ajax(
    type: 'POST'
    url: '/steps/update_examination'
    dataType: 'json'
    data: { step: {name:category_name } }
  )
