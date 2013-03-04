$.compactibleDefaults =
  closedHeight: '30px'
  openCloseButton:
    open:"<div class='open-close open' title='show'><i class='icon icon-open'></i></div>"
    close:"<div class='open-close close' title='hide'><i class='icon icon-close'></i></div>"
  start: 'close'
  wrapperClass: 'compactible-shrink-wrap'

$.fn.compactible = (method) ->
  inArgs = arguments
  methods =
    open: ->
      $this = $(this)
      opts = $this.data()
      opener = $this.find('.open')
      closer = $this.find('.close')
      opener.hide();
      closer.show();
      $this.animate({height: "100%"})
    close: ->
      $this = $(this)
      opts = $this.data()
      opener = $this.find('.open')
      closer = $this.find('.close')
      opener.show();
      closer.hide();
      $this.animate({height: opts.closedHeight})

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

      opener.bind 'click', ->
        $this.compactible('open')
      closer.bind 'click', ->
        $this.compactible('close')

      unless o.openCloseButton[o.start]
        console.log "the start parameter must be one of the following values %s" % _.keys(o.openCloseButton)


  this.each () ->
    # Method calling logic
    if ( methods[method] )
      return methods[ method ].apply( this, Array.prototype.slice.call( inArgs, 1 ));
    else if ( typeof method == 'object' || ! method )
      return methods.init.apply( this, inArgs );
    else
      $.error( 'Method ' +  method + ' does not exist on jQuery.compactible' );
