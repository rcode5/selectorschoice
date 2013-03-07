# admin javascript manifest
# = require pickadate.min
# = require select2

$ ->
  $('.datepicker').pickadate()

  $('.text_copy').bind 'click', ->
    $(this).select()

  $('#track_tag_list, #track_style_list').select2({tags:[]})

  $('#notice').bind 'click', ->
    $(this).fadeOut()

  setTimeout (->
    $('#notice').fadeOut()
  ), 5000
