$.fn.gaEventTracker = function( category, action, label ) {
  
  var delayLink = function(e, url) {
    e.preventDefault();
    setTimeout(function(){
      location.href = url;
    }, 100);
  };

  return this.each(function() {
    var _gaq = _gaq || window._gaq;
    if (!_gaq) {
      throw "GA Eventing is not setup"; 
    } else {
      $(this).bind('click', function(ev) {
        var target = this;
        var args = _.map([category, action, label], function(entry) {
          if(typeof entry === 'function') {
            var val = 0;
            try {
              val = entry.apply(target);
            } catch(ex) {
              console.log("Failed to send event data to GA");
            }
            return val;
          }
          else {
            return entry;
          }
        });
        /** these do not appear to register because we are getting page load before the request is completed */

        /* tried this using .apply with no luck. */
        _gaq.push('_trackEvent', args[0], args[1], args[2]);
        if (this.target !== '_blank') {
          delayLink(ev, this.href);
        }
      });
    }
  });
};

