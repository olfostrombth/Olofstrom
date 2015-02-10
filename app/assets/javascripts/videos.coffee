# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#video_toggle').click ->
    $('.video_form').toggle('show');


    $(document).ready ->
  $(".new_match").on("ajax:success", (e, data, status, xhr) ->
    $(this).hide()
  ).on "ajax:error", (e, xhr, status, error) ->
    $("#new_match").append "<p>ERROR</p>"