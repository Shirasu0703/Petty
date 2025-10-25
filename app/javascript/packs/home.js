import "../stylesheets/home.scss";

$(function() {
  $('.btnx-main').hover(
    function() { $(this).css('background-color', '#6c6b68'); },
    function() { $(this).css('background-color', '#7b7974'); }
    );

  $('.btn-loginx, .btnx-signin').hover(
    function() { $(this).css('background-color', '#c574a0'); },
    function() { $(this).css('background-color', '#f097e0'); }
  );
});