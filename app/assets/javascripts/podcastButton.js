// for the podcast button, we
// want to copy the link and tell the user to put that
// link in their favorite podcast listening app
//

const setupPodcastButton = (el) => {
  $(el).on('click', (event) => {
    const url = $(el).data('feedUrl')
    if (navigator && navigator.clipboard && navigator.clipboard.writeText ) {
      navigator.clipboard.writeText( url )
      alert("Now that you copied the podcast url on your clipboard,\nyou can paste that into your favorite podcast app and start listening!")
    } else {
      alert(`Copy and paste this url ${feedUrl} into your favorite podcast app!`)
    }
  })
}

$(function() {
  $('.podcast-rss-feed-button').each((idx, el) => {
    setupPodcastButton(el)
  })
});

