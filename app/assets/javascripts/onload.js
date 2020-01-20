$(function() {
  $('.home').bind('click', function(ev) {
    location.href = '/';
  });
  $('.audio audio').bind('play', function(ev) {
    if (_gaq && _gaq.push) {
      _gaq.push(['_trackEvent', 'play', $(this).attr('src')]);
    }
  });
  $('.audio audio').bind('pause', function() {
    if (_gaq && _gaq.push) {
      _gaq.push(['_trackEvent', 'pause', $(this).attr('src')]);
    }
  });
  $('.compactible').compactible({
    openCloseButton: {
      open: "<a href='#' class='tooltip open-close open' title='show tracklist'>&#8853;<span class='ie'>+</span></a>",
      close: "<a href='#' class='tooltip open-close close' title='hide tracklist'>&#8854;<span class='ie'>[-]</span></a>"
    }
  });
  $('.flash').on('click', function() {
    $(this).fadeOut();
  });
  $('.flash').each(function(idx, el) {
    var $el;
    $el = $(el);
    return setTimeout(function() {
      $el.fadeOut();
    }, 3500);
  });
  $('.icon-search').bind('click', function() {
    $(this).closest('form').submit();
  });
  if ($('form.search [name=tags]').length) {
    $.ajax({
      url: '/tags.json',
      success: function(d) {
        return $('.search [name=tags]').selectize({
          delimiter: ',',
          options: d.map( function(tag) { return { value: tag, text: tag }; }),
          placeholder: 'search by tag'
        });
      },
      error: function() {
        return $('.search [name=tags]').selectize({
          delimiter: ',',
          items: d,
          placeholder: 'search by tag'
        });
      }
    });
  }
});

