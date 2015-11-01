$(document).ready(function() {
  $('.title').click(function() {
    alert('That worked!')
  });

  $('.name_card').popup({
    popup: '.drop_down'
  });

  $('.dropdown').dropdown();

  $('.log_out').click(function(){
    window.location = '/log_out';
  });
});
