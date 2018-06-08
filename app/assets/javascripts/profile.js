$(function() {
  let $el = $("#today-date");
  let text = $el.text();
  let momentDate = moment(text).format('dddd, DD MMMM');

  $el.text(momentDate);
});
