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
      open:"<a href='#' class='tooltip open-close open' title='show tracklist'>&#8853;</a>"
      close:"<a href='#' class='tooltip open-close close' title='hide tracklist'>&#8854;</a>"
  )
