# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$ ->
  createAudio = (cur, src) ->
    audio = $('<audio>', {src: src, preload: 'auto'})
    $(cur).after(audio);
    $(cur).remove();
    audiojs.create audio,
      preload: true
      imageLocation: '/assets/player-graphics.gif'
      swfLocation: '/assets/audiojs.swf'

  $('.audio .load-audio').bind 'click', (ev) ->
    ev.preventDefault()
    url = $(this).attr('href')
    createAudio this, url
    false
