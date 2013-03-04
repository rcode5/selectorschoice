# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  b = new BrowserSniffer()
  opts = { enablePluginDebug: true }
  if b.browser == 'hrome'
    opts = $.extend(opts, { mode: 'shim'  })
  $('.audio audio').mediaelementplayer(opts)
