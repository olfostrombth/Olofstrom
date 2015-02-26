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
  $('#user_search').typeahead
    name: "name"
    remote: "/autocomplete?query=%QUERY"


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

$(document).ready ->
  # Ajax sorting and pagination on click
  $('#users td.sortable a, #users .pagination a').on 'click', ->
    $.getScript(this.href)


  # Ajax search on submit
  $('#users_search').submit ->
    $.get(this.action, $(this).serialize(), null, 'script')
    $('#test').append this


  # Ajax search on keyup
  $('#users_search input').keyup ->
    $.get($("#users_search").attr("action"), $("#users_search").serialize(), null, 'script')
    $('#test').append this

