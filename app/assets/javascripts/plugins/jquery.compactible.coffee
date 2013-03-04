$.compactibleDefaults =
  openCloseButton:
    open:"<div class='open-close open'>open<i class='icon icon-open'></i></div>"
    close:"<div class='open-close close'>close<i class='icon icon-close'></i></div>"
  start: 'close'
  wrapperClass: 'compactible-shrink-wrap'

$.fn.compactible = (method) ->
  inArgs = arguments
  methods =
    open: ->
      $this = $(this)
      opts = $this.data()
      $this.show()
    close: ->
      $this = $(this)
      opts = $this.data()
      $this.find('.open-close.close').remove()
      $this.find('.open-close.open').remove()
      $this.prepend(opts.openCloseButton.close)
      $this.hide()
    init: (options) ->
      $this = $(this)
      o = $.extend({},$.compactibleDefaults, options);
      $this.data(o);

      $wrapper = $this.wrap($('<div>', {class: o.wrapperClass}));
      $wrapper.prepend('.open-close.close')
      $wrapper.prepend('.open-close.open')
      if o.start == 'close'
        $wrapper.find

      unless o.openCloseButton[o.start]
        console.log "the start parameter must be one of the following values %s" % _.keys(o.openCloseButton)
      el = o.openCloseButton[o.start] || o.openCloseButton['close']
      $this.prepend(el);
      $this.compactible(o.start);


  this.each () ->
    # Method calling logic
    if ( methods[method] )
      return methods[ method ].apply( this, Array.prototype.slice.call( inArgs, 1 ));
    else if ( typeof method == 'object' || ! method )
      return methods.init.apply( this, inArgs );
    else
      $.error( 'Method ' +  method + ' does not exist on jQuery.compactible' );
