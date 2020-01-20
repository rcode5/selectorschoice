// admin javascript manifest
//= require_tree ./support
//= require pickadate.min
//= require jquery.timepicker
//= require selectize

$(function() {
  $('.datepicker').pickadate()
  $('.timepicker').timepicker()
  $('.text_copy').bind('click', function() {
    $(this).select()
  });

  if ($('#track_tag_list, #track_style_list').length) {
    console.log($(this).val())
    $.ajax({
      url: '/tags.json',
      success: function(availableTags) {
        $('#track_tag_list, #track_style_list').selectize({
          create: true,
          options: availableTags.map(function(tag) { return({text: tag, value: tag}) }),
        })
      },
      error: function() {
        $('#track_tag_list, #track_style_list').selectize({
          create: true,
          options: [],
          items: [],
        })
      }
    })
  }

  $('#notice').bind('click', function() {
    $(this).fadeOut()
  })

  setTimeout(function() { $('#notice').fadeOut() }, 3500)
});
