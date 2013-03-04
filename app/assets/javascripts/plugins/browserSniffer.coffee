window.BrowserSniffer = class BrowserSniffer
  constructor: ->
    @_browser = (->
      ua = navigator.userAgent;
      isOpera = Object.prototype.toString.call(window.opera) == '[object Opera]';
      {
        IE:             !!window.attachEvent && !isOpera
        Opera:          isOpera
        WebKit:         ua.indexOf('AppleWebKit/') > -1
        Gecko:          ua.indexOf('Gecko') > -1 && ua.indexOf('KHTML') == -1
        MobileSafari:   /Apple.*Mobile/.test(ua)
      }
    )()

    @browser = @searchString(@dataBrowser) || 'unknown'
    @version = @searchVersion(navigator.userAgent) || @searchVersion(navigator.appVersion) || "an unknown version"
    @OS = @searchString(@dataOS) || "an unknown OS"

  searchString: (data) ->
    i = 0;
    n = data.length
    while i < n
      d = data[i]
      ++i
      dataString = d.string
      dataProp = d.prop
      @versionSearchString = d.versionSearch || d.identity
      if dataString
        if dataString.indexOf(d.subString) != -1
       	  return d.identity
      else if dataProp
  	    return d.identity
    return null
  searchVersion: (dataString) ->
    index = dataString.indexOf(this.versionSearchString);
    if index == -1
      return null
    return parseFloat(dataString.substring(index+this.versionSearchString.length+1))

  dataBrowser: [
    {
      string: navigator.userAgent,
      subString: "Chrome",
      identity: "Chrome"
    },
    {
      string: navigator.userAgent,
      subString: "OmniWeb",
      versionSearch: "OmniWeb/",
      identity: "OmniWeb"
    },
    {
      string: navigator.vendor,
      subString: "Apple",
      identity: "Safari",
      versionSearch: "Version"
    },
    {
      prop: window.opera,
      identity: "Opera"
    },
    {
      string: navigator.vendor,
      subString: "iCab",
      identity: "iCab"
    },
    {
      string: navigator.vendor,
      subString: "KDE",
      identity: "Konqueror"
    },
    {
      string: navigator.userAgent,
      subString: "Firefox",
      identity: "Firefox"
    },
    {
      string: navigator.vendor,
      subString: "Camino",
      identity: "Camino"
    },
    {	# for newer Netscapes (6+)
      string: navigator.userAgent,
      subString: "Netscape",
      identity: "Netscape"
    },
    {
      string: navigator.userAgent,
      subString: "MSIE",
      identity: "Explorer",
      versionSearch: "MSIE"
    },
    {
      string: navigator.userAgent,
      subString: "Gecko",
      identity: "Mozilla",
      versionSearch: "rv"
    },
    { # for older Netscapes (4-)
      string: navigator.userAgent,
      subString: "Mozilla",
      identity: "Netscape",
      versionSearch: "Mozilla"
    }
  ],
  dataOS : [
    {
      string: navigator.platform,
      subString: "Win",
      identity: "Windows"
    },
    {
      string: navigator.platform,
      subString: "Mac",
      identity: "Mac"
    },
    {
      string: navigator.userAgent,
      subString: "iPhone",
      identity: "iPhone/iPod"
    },
    {
      string: navigator.platform,
      subString: "Linux",
      identity: "Linux"
    }
  ]
