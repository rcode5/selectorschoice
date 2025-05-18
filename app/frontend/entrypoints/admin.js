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

// import * as ActiveStorage from '@rails/activestorage'
// ActiveStorage.start()

import Rails from '@rails/ujs';
Rails.start();


import jQuery from 'jquery';
window.$ = jQuery
window.jQuery = jQuery

// js
import '../javascripts/admin'

// stylesheets
import 'selectize/dist/css/selectize.default.css';
import '../../../vendor/assets/stylesheets/jquery.timepicker.css';
import '../stylesheets/admin/admin.css.scss';
import '../stylesheets/admin/admin_forms.css.scss';
import '../stylesheets/admin/tag_cloud.css.scss';
