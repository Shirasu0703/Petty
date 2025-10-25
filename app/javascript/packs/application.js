// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application";

window.$ = $;
window.jQuery = $;
import "../script";


import "stylesheets/header.scss"
import "stylesheets/search.scss"
import "stylesheets/style.scss"
import "stylesheets/tag.scss"
import "stylesheets/hospital.scss"
import "stylesheets/review.scss"
// import "stylesheets/home.scss"

import Raty from "../raty"
window.Raty = Raty;
window.raty = function(elem,opt) {
  const raty =  new Raty(elem,opt)
  raty.init();
  return raty;
};



document.addEventListener("turbolinks:load", function() {
  document.querySelectorAll('.raty-display').forEach((elem) => {
    elem.innerHTML = '';
    const score = parseFloat(elem.dataset.score || 0);
    const readOnly = elem.dataset.readonly === 'true';

    const raty = new Raty(elem, {
      starOn: "/assets/star-on.png",
      starHalf: "/assets/star-half.png",
      starOff: "/assets/star-off.png",
      half: true,
      readOnly,
      score
    });
    raty.init();
  });
});

document.addEventListener("turbolinks:before-cache", function() {
  // ページ遷移前に星評価を空にする
  document.querySelectorAll('.raty-display').forEach((elem) => {
    elem.innerHTML = '';
  });
});

Rails.start()
Turbolinks.start()
ActiveStorage.start()
