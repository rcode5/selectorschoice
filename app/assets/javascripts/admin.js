// admin javascript manifest
//= require_tree ./support
//= require pickadate.min
//= require jquery.timepicker
//= require select2

$(function() {
  $('.datepicker').pickadate()
  $('.timepicker').timepicker()
  $('.text_copy').bind('click', function() {
    $(this).select()
  });

  if ($('#track_tag_list, #track_style_list').length) {
    $.ajax({
      url: '/tags.json',
      success: function(d) {
        $('#track_tag_list, #track_style_list').select2({tags: d})
      },
      error: function() {
        $('#track_tag_list, #track_style_list').select2({tags: []})
      }
    })
  }

  $('#notice').bind('click', function() {
    $(this).fadeOut()
  })

  setTimeout(function() { $('#notice').fadeOut() }, 3500)
});
