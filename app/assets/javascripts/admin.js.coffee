# admin javascript manifest
# = require pickadate.min
# = require select2.min

$ ->
  $('.datepicker').pickadate()

  $('.text_copy').bind 'click', ->
    $(this).select()

  $('form .tags input').select2({tags:['this', 'that']})