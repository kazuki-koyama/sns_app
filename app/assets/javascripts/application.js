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

// フラッシュメッセージのフェイドアウト
$(function(){
  setTimeout("$('.time-limit').fadeOut('slow')", 2000)
});