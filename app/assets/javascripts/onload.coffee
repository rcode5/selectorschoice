$ ->
  #$('.compactible').compactible();
  $('.audio audio').bind 'play', (ev) ->
    _gaq.push(['_trackEvent', 'play', $(this).attr('src')]);
  $('.audio audio').bind 'pause', () ->
    _gaq.push(['_trackEvent', 'pause', $(this).attr('src')]);
