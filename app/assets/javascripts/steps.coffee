# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#video_toggle').click ->
    $('.video_form').toggle('show');

$ ->
  $('#quiz_toggle').click ->
    $('.quiz_form').toggle('show')

$ ->
  $('#guide_toggle').click ->
    $('.guide_form').toggle('show')

$ ->
  $('#assignment_toggle').click ->
    $('.assignment_form').toggle('show')



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

#$ ->
#- $('#submit_quiz').click ->
#- answer1 = document.getElementsByClassName('correct')
##- answer2 = document.getElementsByClassName('option1')
#- answer3 = document.getElementsByClassName('option2')
#- questions = document.getElementsByClassName('question')
#- correct_answers = []
#- i = 0
#- while i < questions.length
#- if answer1[i].type == 'radio' and answer1[i].checked
#- correct_answers.push '1'
#- else if answer2[i].type == 'radio' and answer2[i].checked
#- document.getElementsByClassName('question')[i].style.color = 'red'
#-
#- else if answer3[i].type == 'radio' and answer3[i].checked
#- document.getElementsByClassName('question')[i].style.color = 'red'
#- i++
#- if correct_answers.length == questions.length
#- console.log 'grattis'
#- return
#$ ->
#- questions = document.getElementsByClassName('question')
#- x = 0
#- while x < questions.length
#- random = document.querySelectorAll('.test')[x]
#- i = random.children.length
#- while i >= 0
#- random.appendChild random.children[Math.random() * i | 0]
#- i--
#- x++
#- return
