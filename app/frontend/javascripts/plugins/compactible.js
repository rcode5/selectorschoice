// converted from coffeescript
import $ from 'jquery';

function init() {
  $.compactibleDefaults = {
    closedHeight: '30px',
    openCloseButton: {
      open: "<a class='tooltip open-close open' title='show tracklist'><i class='icon icon-open'></i></a>",
      close: "<a class='tooltip open-close close' title='hide tracklist'><i class='icon icon-close'></i></a>"
    },
    start: 'close',
    wrapperClass: 'compactible-shrink-wrap'
  };

  $.fn.compactible = function(method) {
    var inArgs, methods;
    inArgs = arguments;
    methods = {
      open: function() {
        var $section, $this, closer, opener, opts;
        $this = $(this);
        opts = $this.data();
        if (opts.section) {
          opener = $this.find('.open');
          closer = $this.find('.close');
          opener.hide();
          closer.show();
          $section = $(opts.section);
          if (!$section.is(':visible')) {
            return $(opts.section).slideDown();
          }
        }
      },
      close: function() {
        var $section, $this, closer, opener, opts;
        $this = $(this);
        opts = $this.data();
        if (opts.section) {
          opener = $this.find('.open');
          closer = $this.find('.close');
          opener.show();
          closer.hide();
          $section = $(opts.section);
          if ($section.is(':visible')) {
            return $(opts.section).slideUp();
          }
        }
      },
      init: function(options) {
        var $this, closer, o, opener;
        $this = $(this);
        o = $.extend({}, $.compactibleDefaults, options);
        $this.data(o);
        $this.prepend(o.openCloseButton.open);
        $this.prepend(o.openCloseButton.close);
        opener = $this.find('.open');
        closer = $this.find('.close');
        if (o.start === 'close') {
          $this.compactible('close');
        } else {
          $this.compactible('open');
        }
        opener.bind('click', function(ev) {
          ev.preventDefault();
          $this.compactible('open');
          return false;
        });
        closer.bind('click', function(ev) {
          ev.preventDefault();
          $this.compactible('close');
          return false;
        });
        if (!o.openCloseButton[o.start]) {
          console.log("the start parameter must be one of the following values %s" % _.keys(o.openCloseButton));
        }
      }
    };
    return this.each(function() {
      // Method calling logic
      if (methods[method]) {
        return methods[method].apply(this, Array.prototype.slice.call(inArgs, 1));
      } else if (typeof method === 'object' || !method) {
        return methods.init.apply(this, inArgs);
      } else {
        return $.error('Method ' + method + ' does not exist on jQuery.compactible');
      }
    });
  };

};

export { init }