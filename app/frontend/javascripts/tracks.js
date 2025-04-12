// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
//
import $ from 'jquery';
import iconSprite from 'mediaelement/build/mejs-controls.svg'

// Import stylesheet and shims

$(function() {
  const { MediaElementPlayer } = globalThis;
  var getPlaylistStatus, getTrackTitle;

  var getDownloadLink = function(el, trackId) {
    return $.ajax({
      method: 'get',
      url: '/tracks/' + trackId + '.json'
    }).then(function(resp) {
      return resp.data.attributes.signed_url
    })
  };

  var replaceWithAudioTrack = function(el, trackId) {
    $.ajax({
      method: 'get',
      url: '/tracks/' + trackId + '.json'
    }).then(function(resp) {
      var url = resp.data.attributes.signed_url
      var audioEl = $('<audio>', {
        src: url,
        preload: true,
        type: 'audio/mpeg'
      })
      el.after(audioEl)
      el.remove()

      new MediaElementPlayer(audioEl[0],
        {
          iconSprite: iconSprite,
          audioWidth: 400,
          success: function(mediaElement, domObject) {
            mediaElement.play();
          },
        })
      })
    }

    $('.audio .js-pre-audio').on('click', function(ev) {
      var $el = $(ev.currentTarget)
      var trackId = $el.attr('track_id')
      replaceWithAudioTrack($el, trackId)
    })

    $('.js-pre-download').on('click', function(ev) {
      var $el = $(ev.currentTarget)
      var trackId = $el.attr('track_id')
      getDownloadLink($el, trackId).then(function(url) {
        window.open(url);
      })
    })

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

    $('li.track .download').gaEventTracker('Download', getTrackTitle);
  });
