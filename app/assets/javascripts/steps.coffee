# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).on "click", "#video_toggle", ->
    $('.video_form').toggle('show')

#Gets all checkboxes for the substep check if done part
getAllDone = ->
  return document.getElementsByClassName("donebox");

getSubSteps = ->
  raw = document.getElementsByClassName("donebox")
  substeps = {}
  for x,y in raw
    id = $(x).attr("id")
    if $(x).is(":checked")
      substeps[id] = true
      console.log "Checked is true: " + JSON.stringify(substeps)
    else
      substeps[id] = false
      console.log "Checked is false: " + JSON.stringify(substeps)
  return substeps


#returns if all the checkboxes for the substep check is checked or not (true/false)
#This is because we want to see if the entire step is done
getAllChecked = ->
  all = getAllDone()
  notDone = []
  for x,y in all
    if $(x).is(":checked")
      console.log notDone
    else
      notDone.push(x)

  if notDone.present()
    return false
  else
    return true

getSubStep = (thiss) ->
  substep = {}
  substep[$(thiss).attr("id")] = if $(thiss).is(":checked") then true else false
  return substep
#What happens when you check one of the substep checkboxes?
#This will call the function to see if every box is checked after
#Should send the updates to the local json object and then update DB with the values



$ ->
  if gon.completion
    substeps = $.parseJSON(gon.completion)
    if substeps
      substepsx = substeps[gon.catname][gon.stepname]
      for x,y of substepsx
        if y == "true"
          $("#"+x).prop("checked", true)
        else if y == "false"
          $("#"+x).prop("checked", false)

$(document).on "click", ".donebox", ->
  #console.log ""
  substeps = getSubStep(this)
  console.log substeps
  category_name = gon.catname
  step_name = gon.stepname
  completion = gon.completion
  #Update completion <<< Here
  #Update database <<< Here
  $.ajax(
    type: 'POST'
    url: '/steps/update_completion'
    dataType: 'json'
    data: { step: {name:category_name, step_name:step_name, substepsx: substeps } }
  )
    #Should be done through AjAX probably best way
    #LEts see what we can do.

  tese = getAllDone()
  if getAllChecked()
    alert "Du är klar med det här steget nu!"
    #Update completion for Step is done fully <<
    #Update database for Step is done fully <<<
    #Should be done through AJAX probably
  #for x,y in tese
  #  if $(x).is(":checked")
  #    console.log x + " is checked"
  #  else
  #    console.log x + " is not checked"

$(document).on "click", "#show_video", ->
  video = $(this).parent().find('#video_url')
  video.toggle('show')
  if $(this).html() == 'Visa mer' then $(this).html('Dölj') else $(this).html('Visa mer')


$(document).on "click", "#show_desc", ->
  desc = $(this).parent().find('#desc')
  desc.toggle('show')
  if $(this).html() == 'Visa mer' then $(this).html('Dölj') else $(this).html('Visa mer')


$(document).on "click", "#show_questions", ->
  questions = $(this).parent().find('#quiz_questions')
  questions.toggle('show')
  if $(this).html() == 'Visa mer' then $(this).html('Dölj') else $(this).html('Visa mer')


$(document).on "click", "#show_questions_form", ->
  $(this).siblings('#questions_formx').toggle('show')
  if $(this).html() == 'Lägg till frågor' then $(this).html('Dölj') else $(this).html('Lägg till frågor')


$(document).on "click", "#drop_down_menu", ->
  select = $(this).children()
  $(select).on 'change', ->
    #form = $(this).parent().siblings().find('#forms')
    $('.guide_form').hide()
    $('.assignment_form').hide()
    $('.video_form').hide()
    $('.quiz_form').hide()
    $("#"+select.val()).toggle('show ')
    $(this).off(select)
  $(this).off("#drop_down_menu")


  #When submit_quiz div is clicked, do the following
$(document).on "click", "#submit_quiz", (e) ->
  #Gets the quiz id for later use
  qid = getQuestions(this)

  #console.log qid
  #Create a jquery object for the specific quiz div, select the quiz
  quiz = $("#quiz_"+qid)
  #Setup some variables to be used later
  window.qn = null
  window.checked = null
  wrong = []

  #Select questions inside the quiz
  quizchild = quiz.children() #Gets all questions like so in an object, I THINK

  #Loop through the questions one at a time
  for z,y in quizchild
    #Iterate if id = submit_quiz
    if $(z).attr('id') == 'submit_quiz'
      break

    #Get children of a question
    question = $(z).children()

    #Loop through the options
    for u,i in question

      #Check if the id exists, so it ignores <br>
      if $(u).attr('id')?

        #Set the length of our option array
        window.qn = $(u).length
        #The correct answer to the question, modify later
        correct = null

        #Get children of options, used for getting each individual options params
        options = $(question).children()

        #Loop the options and check if they're correct, if it's wrong, push it to a variable 'wrong' for later use
        for d,i in options
          child = $(d).children()[1]
          if $(child).is(":checked")
            window.checked+=1
            if $(child).attr('id') == 'correct'
              correct = $(child).attr('id')
            else
              $(child).css("color", "red")
              wrong.push $(u).attr('id')

    #Check if 'wrong' has anything in it
    if wrong.present()
      for o,i in wrong
        $('#'+o).css('color', 'red')

        console.log o
        console.log "This quiz is wrong.. This is bad!"

      #If it hasn't, check if all boxes are filled, if they are, the quiz is correctly answered
    else if !wrong.present() && window.checked == window.qn + 1
      console.log "This quiz is correctly answered yes guys!!!!"
      #Else, not all boxes are checked
    else
      console.log "Not all boxes in this quiz checked!"

Array::present = ->
  @.length > 0

getQuestions = (thiss) ->
  fvalue = $(thiss).attr("quiz")
  return fvalue

shuffle = ->
  quizzes = $(document).find('.quiz')

  for x,y in quizzes.toArray()
    #console.log x
    questions = $(x).children()
    #console.log questions
    for z, b in questions.toArray()
      #console.log z
      random = $(z).children()

      #console.log random
      for i, r in random
        #console.log i
        #console.log r
        if $(i).attr('id')?
          #console.log i

          i.appendChild random[Math.random() * r | 0]
  return

window.onload = ->
  shuffle()

normalize = (name) ->
  return name.toLowerCase().replace(/['’]/gi, '').replace(/ /gi, '-').replace(/[àáâãäå]/gi, 'a').replace(/[ö]/gi, 'o')

getStepItems = (item) ->
  fvalue = $(item).attr("step_item")
  return fvalue
