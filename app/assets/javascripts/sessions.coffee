# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
submit = (thiss, e) ->
  if e.type == 'click'
    $(thiss).find('#user_admin').on 'change', ->
      console.log "Testar att det funkar"
      $(thiss).submit()
      $(thiss).find('#user_admin').unbind('change')
      $(thiss).find('#user_admin').unbind('click')
      e.off('click')

$ ->
  $(document).on "click", ".edit_user", (e) ->
    submit(this, e)

  $(document).on "click", "#appendToArray", (e) ->
    completion = $.parseJSON(gon.completion)
    completion.Modul3 ={
        "Step431": {
          "Video_81": true,
          "Quiz_83": true
        },
        "Step34": {
          "Video_821": true,
          "Quiz_823": true
        },
        "Examination": {
          "Completed": true,
          "Rattad": true
        }
      }

    console.log(completion)
