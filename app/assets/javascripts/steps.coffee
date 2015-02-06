# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#submit_quiz').click ->
    radios = document.getElementsByClassName('correct')
    answers = []
    i = 0
    while i < radios.length
      if radios[i].type == 'radio' and radios[i].checked
        answers.push 'true'
      else
        answers.push 'false'
        document.getElementById('question').style.color = 'red'
      i++
      console.log answers
    return







