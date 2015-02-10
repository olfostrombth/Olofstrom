# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.edit_user').click ->
    submit(this)


submit = (thiss) ->
  $(thiss).find('#user_admin').on 'change', ->
    console.log "Testar att det funkar"
    $(thiss).submit();
    $(thiss).find('#user_admin').unbind('change')
