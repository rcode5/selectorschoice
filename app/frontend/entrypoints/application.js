// To see this message, add the following to the `<head>` section in your
// views/layouts/application.html.erb
//
//    <%= vite_client_tag %>
//    <%= vite_javascript_tag 'application' %>
//console.log('Vite ⚡️ Rails')

// If using a TypeScript entrypoint file:
//     <%= vite_typescript_tag 'application' %>
//
// If you want to use .jsx or .tsx, add the extension:
//     <%= vite_javascript_tag 'application.jsx' %>

// console.log('Visit the guide for more information: ', 'https://vite-ruby.netlify.app/guide/rails')

// Example: Load Rails libraries in Vite.
//
// import * as Turbo from '@hotwired/turbo'
// Turbo.start()
//
// import ActiveStorage from '@rails/activestorage'
// ActiveStorage.start()
//
// // Import all channels.
// const channels = import.meta.globEager('./**/*_channel.js')

// Example: Import a stylesheet in app/frontend/index.css
// import '~/index.css'

import Rails from '@rails/ujs';
Rails.start();

import 'jquery'
import 'jquery-ujs'
import 'selectize'
import '../javascripts/onload'
import '../javascripts/podcastButton'
import '../javascripts/tracks'
import 'mediaelement'

// css
import 'selectize/dist/css/selectize.default.css';
import '../stylesheets/application/about.css.scss';
import '../stylesheets/application/loveli-icons.css.scss';
import '../stylesheets/application/main.css.scss';
import '../stylesheets/application/search.css.scss';
import '../stylesheets/application/shutdown.css.scss';
import '../stylesheets/application/site-nav.css.scss';
import '../stylesheets/application/tooltips.css.scss';
import '../stylesheets/application/tracks.css.scss';

import 'mediaelement/build/mediaelementplayer.min.css';
