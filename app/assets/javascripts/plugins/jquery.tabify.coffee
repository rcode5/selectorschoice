$.tabifyDefaults = {}

$.fn.tabify = (method) ->
  inArgs = arguments
  methods =
    init: (options) ->
      $this = $(this)
      o = $.extend({},$.tabifyDefaults, options);
      $this.bind 'click', (ev) ->
        ev.preventDefault()
        tab_links = []
        $(this).find('a').each ->
          $(this).removeClass('current')
          tab_links.push($(this).attr('href'))
        $(tab_links.join ',').hide()
        $($(ev.target).attr('href')).show()
        $(ev.target).addClass('current')

  this.each ->
    # Method calling logic
    if ( methods[method] )
      return methods[ method ].apply( this, Array.prototype.slice.call( inArgs, 1 ));
    else if ( typeof method == 'object' || ! method )
      return methods.init.apply( this, inArgs );
    else
      $.error( 'Method ' +  method + ' does not exist on jQuery.compactible' );

$ ->
  $('.tabs').tabify()

# $('#tabs div').hide();
# $('#tabs div:first').show();
# $('#tabs ul li:first').addClass('active');

# $('#tabs ul li a').click(function(){
# $('#tabs ul li').removeClass('active');
# $(this).parent().addClass('active');
# var currentTab = $(this).attr('href');
# $('#tabs div').hide();
# $(currentTab).show();
# return false;
# });
# });
