# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).on "click", "#submit_video", (e) ->
    $(this).parent().parent().submit()
    video_name = $(this).parent().parent().find('#video_name').val()
    video_url = $(this).parent().parent().find('#video_url').val()
    $('#videos').append video_name
    $('#videos').append video_url




