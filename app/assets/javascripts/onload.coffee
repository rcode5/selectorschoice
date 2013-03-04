$ ->
  #$('.compactible').compactible();
  $('.audio audio').bind 'play', (ev) ->
    if (_gaq && _gaq.push)
      _gaq.push(['_trackEvent', 'play', $(this).attr('src')]);
  $('.audio audio').bind 'pause', () ->
    if (_gaq && _gaq.push)
      _gaq.push(['_trackEvent', 'pause', $(this).attr('src')]);

  $('.compactible').compactible(
    start:'open'
    openCloseButton:
      open:"<div class='open-close open' title='show'>&#8853;</div>"
      close:"<div class='open-close close' title='hide'>&#8854;</div>"
  )
