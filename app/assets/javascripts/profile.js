// Main date on profile/dashboard page. Format using MomentJS
$(function() {
  let $el = $("#today-date");
  let text = $el.text();
  let momentDate = moment(text).format('dddd, DD MMMM');

  $el.text(momentDate);
});

// Every achievement in the list should have a "X days ago"
// Formatted with MomentJS
$(function() {
  $('.time-ago').each(function(key) {
    let momentDate = moment($(this).text()).fromNow();
    let formattedDate = moment($(this).text()).format('lll');
    $(this).text(momentDate);
    $(this).attr('title', formattedDate);
  });
});
