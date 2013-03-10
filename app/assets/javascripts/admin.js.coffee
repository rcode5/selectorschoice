# admin javascript manifest
# = require_tree ./support
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
        $('#track_tag_list, #track_style_list').select2({tags: d})
      error: ->
        $('#track_tag_list, #track_style_list').select2({tags: []})
    )

  $('#notice').bind 'click', ->
    $(this).fadeOut()

  setTimeout (->
    $('#notice').fadeOut()
  ), 3500
