# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('#assignment_id').click ->
    if $('#assignment_id').is(":checked")
      console.log "Hej!"
      #Do stuff with completion JSON here i.e add that assignment is done
