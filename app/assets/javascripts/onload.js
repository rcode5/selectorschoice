$(function() {
  $('.home').bind('click', function(ev) {
    return location.href = '/';
  });
  $('.audio audio').bind('play', function(ev) {
    if (_gaq && _gaq.push) {
      return _gaq.push(['_trackEvent', 'play', $(this).attr('src')]);
    }
  });
  $('.audio audio').bind('pause', function() {
    if (_gaq && _gaq.push) {
      return _gaq.push(['_trackEvent', 'pause', $(this).attr('src')]);
    }
  });
  $('.compactible').compactible({
    openCloseButton: {
      open: "<a href='#' class='tooltip open-close open' title='show tracklist'>&#8853;<span class='ie'>+</span></a>",
      close: "<a href='#' class='tooltip open-close close' title='hide tracklist'>&#8854;<span class='ie'>[-]</span></a>"
    }
  });
  $('.flash').on('click', function() {
    return $(this).fadeOut();
  });
  $('.flash').each(function(idx, el) {
    var $el;
    $el = $(el);
    return setTimeout(function() {
      return $el.fadeOut();
    }, 3500);
  });
  $('.icon-search').bind('click', function() {
    return $(this).closest('form').submit();
  });
  if ($('form.search [name=tags]').length) {
    return $.ajax({
      url: '/tags.json',
      success: function(d) {
        return $('.search [name=tags]').select2({
          tags: d,
          placeholder: 'search'
        });
      },
      error: function() {
        return $('.search [name=tags]').select2({
          tags: [],
          placeholder: 'search by tag'
        });
      }
    });
  }
});

// ---
// generated by coffee-script 1.9.2
