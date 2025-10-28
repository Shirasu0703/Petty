import "../stylesheets/style.scss";

$(function() {
  $('.btn-link-color').hover(
    function() { $(this).css('background-color', '#6c6b68'); },
    function() { $(this).css('background-color', '#7b7974'); }
    );
  });
