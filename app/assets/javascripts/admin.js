/* admin javascript manifest
 *= require pickadate.min
 */

$(function() {
  $('.datepicker').pickadate();
});

$('.text_copy').bind('click', function() {
  $(this).select();
});
