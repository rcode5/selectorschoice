$ ->
  $('.audio audio').bind 'play', (ev) ->
    if (_gaq && _gaq.push)
      _gaq.push(['_trackEvent', 'play', $(this).attr('src')]);
  $('.audio audio').bind 'pause', () ->
    if (_gaq && _gaq.push)
      _gaq.push(['_trackEvent', 'pause', $(this).attr('src')]);

  $('.compactible').compactible(
    openCloseButton:
      open:"<a href='#' class='tooltip open-close open' title='show tracklist'>&#8853;<span class='ie'>+</span></a>"
      close:"<a href='#' class='tooltip open-close close' title='hide tracklist'>&#8854;<span class='ie'>[-]</span></a>"
  )

  $('.flash').bind 'click', () ->
    $(this).fadeOut()

  $('.flash').each (idx, el) ->
    $el = $(el)
    setTimeout ->
      $el.fadeOut()
    ,
      3500

  $('.icon-search').bind 'click', () ->
    $(this).closest('form').submit()

  if $('form.search [name=tags]').length
    $.ajax(
      url:'/tags.json'
      success: (d) ->
        $('.search [name=tags]').select2({tags: d, placeholder: 'search'})
      error: ->
        $('.search [name=tags]').select2({tags: [], placeholder: 'search by tag'})
    )
