$(function() {
  $("#avatar-input").on('change', function() {
    generatePreview(this);
  });

  function generatePreview(input)  {
    if (input.files && input.files[0]) {
      var reader = new FileReader();

      reader.onload = function (e) {
        $('#user-avatar').attr('src', e.target.result);
      }

      reader.readAsDataURL(input.files[0]);
    }
  }
});
