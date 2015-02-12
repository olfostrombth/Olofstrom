# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready ->
  $('.new_question').on('ajax:success', (e, data, status, xhr) ->
    $('#quizzes').append(this)
  ).on 'ajax:error', (e, xhr, status, error) ->
    $('#quizzes').append "<p>ERROR</p>"