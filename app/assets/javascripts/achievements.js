$(function() {
  $("button.submit-assign-achievement").click(function(event) {
    var $row = $(event.target).closest('.achievement-row');
    var achievement_id = $row.data('achievement-id');
    $('input[name="achievement_id"]').val(achievement_id);
    $('#assign-achievement-form').submit();
  })
});
