# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  b = new BrowserSniffer()
  $('.audio audio').mediaelementplayer(audioWidth: 400, pluginPath: '/assets/', plugins:['flash'])


  getTrackTitle = ->
    track = $(this).closest('li.track')
    if track
      $(track).find('.hd .title').text().trim()

  getPlaylistStatus = ->
    if $(this).hasClass('open') then 'open' else 'close'

  $('li.track .open-close').gaEventTracker('Playlist', getTrackTitle, getPlaylistStatus)

  $('li.track .download').gaEventTracker('Download', getTrackTitle)