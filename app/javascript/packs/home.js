import "../stylesheets/home.scss";
import "../images/cat_image.jpg";

$(function(){
  $('.btn-main').mouseover(function(){
    $('.btn-main').css({'background-color': '#6c6b68'});
  });
  $('.btn-main').mouseout(function(){
    $('.btn-main').css({'background-color': '#7b7974'});
  });
});

$(function(){
  $('.btn-login').mouseover(function(){
    $('.btn-login').css({'background-color': '#c574a0'});
  });
  $('.btn-login').mouseout(function(){
    $('.btn-login').css({'background-color': '#f097e0'});
  });
});

$(function(){
  $('.btn-signin').mouseover(function(){
    $('.btn-signin').css({'background-color': '#c574a0'});
  });
  $('.btn-signin').mouseout(function(){
    $('.btn-signin').css({'background-color': '#f097e0'});
  });
});