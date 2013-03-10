$.compactibleDefaults =
  closedHeight: '30px'
  openCloseButton:
    open:"<a class='tooltip open-close open' title='show tracklist'><i class='icon icon-open'></i></a>"
    close:"<a class='tooltip open-close close' title='hide tracklist'><i class='icon icon-close'></i></a>"
  start: 'close'
  wrapperClass: 'compactible-shrink-wrap'

$.fn.compactible = (method) ->
  inArgs = arguments
  methods =
    open: ->
      $this = $(this)
      opts = $this.data()
      if opts.section
        opener = $this.find('.open')
        closer = $this.find('.close')
        opener.hide();
        closer.show();
        $section = $(opts.section)
        if !$section.is(':visible')
          $(opts.section).slideDown()
    close: ->
      $this = $(this)
      opts = $this.data()
      if (opts.section)
        opener = $this.find('.open')
        closer = $this.find('.close')
        opener.show();
        closer.hide();
        $section = $(opts.section)
        if $section.is(':visible')
          $(opts.section).slideUp()

    init: (options) ->
      $this = $(this)
      o = $.extend({},$.compactibleDefaults, options);
      $this.data(o);

      $this.prepend(o.openCloseButton.open)
      $this.prepend(o.openCloseButton.close)
      opener = $this.find('.open')
      closer = $this.find('.close')
      if o.start == 'close'
        $this.compactible('close');
      else
        $this.compactible('open');

      opener.bind 'click', (ev) ->
        ev.preventDefault();
        $this.compactible('open')
        return false
      closer.bind 'click', (ev) ->
        ev.preventDefault();
        $this.compactible('close')
        return false
      unless o.openCloseButton[o.start]
        SC.log "the start parameter must be one of the following values %s" % _.keys(o.openCloseButton)


  this.each () ->
    # Method calling logic
    if ( methods[method] )
      return methods[ method ].apply( this, Array.prototype.slice.call( inArgs, 1 ));
    else if ( typeof method == 'object' || ! method )
      return methods.init.apply( this, inArgs );
    else
      $.error( 'Method ' +  method + ' does not exist on jQuery.compactible' );
