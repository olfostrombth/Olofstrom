# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
submit = (thiss) ->
  $(thiss).find('#user_admin').on 'change', ->
    console.log "Testar att det funkar"
    $(thiss).submit();
    $(thiss).find('#user_admin').unbind('change')


$ ->
  $(document).on "click", ".edit_user", (e) ->
    submit(this)
