SC = SC || window.SC = window.SC || {}

SC.log = () ->
  if window.console
    try
      console.log.apply this, arguments_
    catch e
      try
        i = 0
        n = arguments_.length
        while i < n
          console.log arguments_[i]
          ++i
      catch ee
        L.log = ->
