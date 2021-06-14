// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require jquery.jscroll.min.js
//= require bxslider
//= require popper
//= require bootstrap-sprockets

//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

$(document).on('turbolinks:load', function() {
  $('.jscroll').jscroll({
    contentSelector: '.jscroll',
    nextSelector: 'a.next',
    loadingHtml: '読み込み中'
  });
});

// $(document).ready(function() {
$('.slider').on('click', function() {
  $('.bxslider').bxSlider({
    // pager: true,
    // controls: true,
    // moveSlides: 1,
    // maxSlides: 2,
    nextText: "→",
    prevText: "←",
    slideWidth: 300
  });
});

// let slider1 = new SliderInit('.slider1','.slide-counter1','.slide-counter1 span');
// // モーダルの設定
// let sliderModalSet1 = {
// el: '.sliderModal1',
// sliderModaleEl: '.slider1 li a',
// sliderModaleWrap: '.sliderModalWrap1',
// mode: 'fade',
// speed: 400
// }
// let sliderModal1 = new SliderModalInit(sliderModalSet1);