# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).on "click", "#video_toggle", ->
    $('.video_form').toggle('show')

$ ->
  $(document).on "click", "#quiz_toggle", ->
    $('.quiz_form').toggle('show')

$ ->
  $(document).on "click", "#guide_toggle", ->
    $('.guide_form').toggle('show')

$ ->
  $(document).on "click", "#assignment_toggle", ->
    $('.assignment_form').toggle('show')

$ ->
  $(document).on "click", "#show_video", ->
    video = $(this).parent().find('#video_url')
    video.toggle('show')

$ ->
  $(document).on "click", "#show_desc", ->
    desc = $(this).parent().find('#desc')
    desc.toggle('show')

$ ->
  $(document).on "click", "#show_questions", ->
    questions = $(this).parent().find('#quiz_questions')
    questions.toggle('show')

$ ->
  $(document).on "click", "#drop_down_menu", ->
    select = $(this).children()
    $(select).on 'change', ->
      #form = $(this).parent().siblings().find('#forms')
      $('.guide_form').hide()
      $('.assignment_form').hide()
      $('.video_form').hide()
      $('.quiz_form').hide()
      $("#"+select.val()).toggle('show ')
      $(this).unbind("change")
    $(this).unbind("click")
    $(this).unbind("change")

$ ->
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
          $(this).find(o).css('background', 'red')
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

$ ->
  $(document).on "click", "#submit_step", (e) ->
    $(this).parent().parent().submit()
    step = $(this).parent().parent().find('#step_name').val()
    $('#steps').append '<a href="/modul/'+gon.catname+'/'+normalize(step)+'">'+step+'</a>'
    $(this).parent().parent().hide()

getStepItems = (item) ->
  fvalue = $(item).attr("step_item")
  return fvalue

$ ->
  $(document).on "click", "#video_form", ->
    sid = getStepItems(this)
    step_item = $("#step_item_"+sid)
    form = $(this).children()
    form.submit()
    video_name = form.find('#video_name').val()
    video_url = form.find('#video_url').val()
    step = $(this).parent().parent()
    step.append '</div><div class="step_items" id="'+step_item+'"><h3>'+video_name+'</h3>'+video_url+''
    #form.submit()
    #console.log $(this).parent().parent().parent()
    #sid = getStepItems(this)
    #console.log sid
    #step_item = $("#step_item_"+sid)
    #console.log step_item
    #$(this).parent().parent().submit()
    #console.log $(this).parent().parent().find('#video_name').val()
    #console.log $(this).parent().parent().find('#video_url').val()
    #step_item.append video_name
    #step_item.append video_url




