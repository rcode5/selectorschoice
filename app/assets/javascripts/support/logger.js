var SC;

SC = SC || (window.SC = window.SC || {});

SC.log = function() {
  var e, ee, i, n, results;
  if (window.console) {
    try {
      return console.log.apply(this, arguments_);
    } catch (_error) {
      e = _error;
      try {
        i = 0;
        n = arguments_.length;
        results = [];
        while (i < n) {
          console.log(arguments_[i]);
          results.push(++i);
        }
        return results;
      } catch (_error) {
        ee = _error;
        return L.log = function() {};
      }
    }
  }
};
