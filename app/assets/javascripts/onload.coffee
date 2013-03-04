$ ->
  #$('.compactible').compactible();
  $('.audio audio').bind 'play', (ev) ->
    if (_gaq && _gaq.push)
      _gaq.push(['_trackEvent', 'play', $(this).attr('src')]);
  $('.audio audio').bind 'pause', () ->
    if (_gaq && _gaq.push)
      _gaq.push(['_trackEvent', 'pause', $(this).attr('src')]);
