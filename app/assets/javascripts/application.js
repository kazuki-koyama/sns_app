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
//= require popper
//= require bootstrap-sprockets

//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

// 無限スクロール
$(document).on('turbolinks:load', function() {
  $('.jscroll').jscroll({
    contentSelector: '.jscroll',
    nextSelector: 'a.next',
    loadingHtml: '読み込み中'
  });
});

// ツールチップ
$(document).on('turbolinks:load', function() {
  $('.tool-tip').hide();
  $('input[name="keyword"]').focus(function() {
    $(".tool-tip").fadeToggle("fast", "linear");
  });
  $('input[name="keyword"]').focusout(function() {
    $(".tool-tip").fadeToggle("fast", "linear");
  });
});

// 投稿画像プレビュー
$(document).on('turbolinks:load', function() {
  $('#post_before_image').on('change', function (e) {
    var reader = new FileReader();
    reader.onload = function (e) {
      $("#before_image_preview").attr('src', e.target.result);
    }
    reader.readAsDataURL(e.target.files[0]);
  });
});
$(document).on('turbolinks:load', function() {
  $('#post_after_image').on('change', function (e) {
    var reader = new FileReader();
    reader.onload = function (e) {
      $("#after_image_preview").attr('src', e.target.result);
    }
    reader.readAsDataURL(e.target.files[0]);
  });
});

// フラッシュメッセージのフェイドアウト
$(function(){
  setTimeout("$('.time-limit').fadeOut('slow')", 2000)
});