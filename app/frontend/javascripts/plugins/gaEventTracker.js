import $ from 'jquery'


function init() {
  // jQuery Plugin to simplify Google Events tracking

  // Event data can be stored in the target element in data- bits, or it can be passed in to the method
  // on initialization, or it can be passed in as methods to compute the values when the tracker fires.

  // Given the following DOM elements,

  //  <a class="trackit default" data-category="my category" data-label="my label" data-action="my action'>track this link</a>
  //  <a class="trackit with-values">track with values</a>
  //  <a class="trackit with-functions" id="thislink">track with functions</a>

  // You might add (initialize the plugin like this):

  //  // to use the data values from the tag
  //  $('.trackit.default').gaEventTracker()

  //  // to specify values
  //  $('.trackit.with-values').gaEventTracker('This Category', 'This Label', 'This Action')

  //  // to specify functions
  //  var getCategory = function() { return this.innerHTML; }
  //  $('.trackit.with-functions').gaEventTracker(getCategory)

  //  If you send in a function, but the result is null or undefined, we'll use the default value of 'empty'.

  //  Author: Jon Rogers <jon@bunnymatic.com>
  //  Github: https://github.com/bunnymatic

  $.fn.gaEventTracker = function(category, action, label) {
    var getAction, getCategory, getLabel;
    getCategory = function() {
      return $(this).data('category');
    };
    getAction = function() {
      return $(this).data('action');
    };
    getLabel = function() {
      return $(this).data('label');
    };
    return this.each(function() {
      return $(this).bind("click", function(ev) {
        var args, target;
        target = this;
        category || (category = getCategory);
        action || (action = getAction);
        label || (label = getLabel);
        args = $.map([category, action, label], function(entry) {
          var val;
          if (typeof entry === "function") {
            try {
              val = entry.apply(target);
            } catch (error) {}
            return val || 'empty';
          } else {
            return entry;
          }
        });
        window._gaq.push(["_trackEvent", args[0], args[1], args[2]]);
        return true;
      });
    });
  };

}

export { init }
