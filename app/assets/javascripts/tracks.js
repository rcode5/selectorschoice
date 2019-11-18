// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
//
$(function() {
  var b, getPlaylistStatus, getTrackTitle;
  b = new BrowserSniffer();

  var replaceWithAudioTrack = function(el, trackId) {
    $.ajax({
      method: 'get',
      url: '/tracks/' + trackId + '.json'
    }).then(function(resp) {
      var url = resp.data.attributes.signed_url
      var audioEl = $('<audio>', {
        src: url,
        preload: false,
        type: 'audio/mpeg'
      })
      el.after(audioEl)
      el.remove()
      audioEl.mediaelementplayer({
        audioWidth: 400,
        pluginPath: '/assets/',
        success: function(mediaElement, domObject) {
          mediaElement.play();
        },
      })
    })
  }
  
  $('.audio .pre-audio').on('click', function(ev) {
    var $el = $(ev.target)
    var trackId = $el.attr('track_id')
    replaceWithAudioTrack($el, trackId)
  })
  $('.audio audio').mediaelementplayer({
    audioWidth: 400,
    pluginPath: '/assets/',
    plugins: ['flash']
  });
  getTrackTitle = function() {
    var track;
    track = $(this).closest('li.track');
    if (track) {
      return $(track).find('.hd .title').text().trim();
    }
  };
  getPlaylistStatus = function() {
    if ($(this).hasClass('open')) {
      return 'open';
    } else {
      return 'close';
    }
  };
  $('li.track .open-close').gaEventTracker('Playlist', getTrackTitle, getPlaylistStatus);
  return $('li.track .download').gaEventTracker('Download', getTrackTitle);
});
