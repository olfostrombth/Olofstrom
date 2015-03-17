# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Archivement badges show
$(document).on "click", ".arch-toggle", ->
  $('.arch').slideToggle 'slow'
  return

$(document).on "click", ".fed", ->
  $('.fed-toggle').slideToggle 'slow'
  return

$(document).on "click", ".add-mod-btn2", ->
  $('.feeed').slideToggle 'slow'
  return

btn = false

# MOBIL MENY JS
$(document).on "click", ".mobile-menu-btn", ->
  if btn
    $('.mobile-menu-btn').animate { left: '0' }, 500
    btn = false
  else
    $('.mobile-menu-btn').animate { left: '85%' }, 500
    btn = true
    $('.sidebar').animate { width: 'toggle' }, 500
  return
  return


$(document).on "click", "#step_toggle", ->
  $('.step_form').slideToggle(500)
  $('.examination_form').hide()


$(document).on "click", "#examination_toggle", ->
  $('.examination_form').slideToggle(500)
  $('.step_form').hide()


$(document).on "click", "#module_toggle", ->
  $('.module_form').slideToggle(500)


$(document).on "click", "#reply_toggle", ->
  $(this).parent().children('#reply_form').toggle('show')


$(document).on "click", "#comment_toggle", ->
  $('.comment_form').slideToggle(500)

$(document).on "click", "#answer-btn", ->
  $(this).parent().parent().children('#replies').slideToggle('show')


  if $(this).html() == '<i class="fa fa-plus"></i>' then $(this).html('<i class="fa fa-minus"></i>') else $(this).html('<i class="fa fa-plus"></i>')





