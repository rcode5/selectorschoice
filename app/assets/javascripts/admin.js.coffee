# admin javascript manifest
# = require pickadate.min
# = require jquery.timepicker
# = require select2

$ ->
  $('.datepicker').pickadate()
  $('.timepicker').timepicker()
  $('.text_copy').bind 'click', ->
    $(this).select()

  if $('#track_tag_list, #track_style_list').length
    $.ajax(
      url:'/tags.json'
      success: (d) ->
        $('#track_tag_list, #track_style_list').select2({tags: d, placeholder: 'search by tag'})
      error: ->
        $('#track_tag_list, #track_style_list').select2({tags: [], placeholder: 'search by tag'})
    )

  $('#notice').bind 'click', ->
    $(this).fadeOut()

  setTimeout (->
    $('#notice').fadeOut()
  ), 3500
