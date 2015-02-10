# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#submit_quiz').click ->
    answer1 = document.getElementsByClassName('correct')
    answer2 = document.getElementsByClassName('option1')
    answer3 = document.getElementsByClassName('option2')
    questions = document.getElementsByClassName('question')
    correct_answers = []
    i = 0
    while i < questions.length
      if answer1[i].type == 'radio' and answer1[i].checked
        correct_answers.push '1'
      else if answer2[i].type == 'radio' and answer2[i].checked
        document.getElementsByClassName('question')[i].style.color = 'red'

      else if answer3[i].type == 'radio' and answer3[i].checked
        document.getElementsByClassName('question')[i].style.color = 'red'
      i++
    if correct_answers.length == questions.length
      console.log 'grattis'
    return


$ ->
  questions = document.getElementsByClassName('question')
  x = 0
  while x < questions.length
    random = document.querySelectorAll('.test')[x]
    i = random.children.length
    while i >= 0
      random.appendChild random.children[Math.random() * i | 0]
      i--
    x++
  return








