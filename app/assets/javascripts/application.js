// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require_tree .

function showForm(commentId) {
  event.preventDefault();

  $('.hide_form.' + commentId).toggle();
}

function deleteComment(commentId) {
  event.preventDefault();

  $.ajax({
    url: '/comments/' + commentId,
    method: 'DELETE',
    success: function(response) {
      alert(response.body)
    },
    error: function() {
      alert('error')
    }
  })
}

function editComment(commentId) {
  event.preventDefault();

  $.ajax({
    url: '/comments/' + commentId + '/edit',
    method: 'GET',
    success: function() {
      $('.hide_form.' + commentId).html("<%= escape_javascript(render partial: 'comments/form') %>")
    },
    error: function() {
      alert('error')
    }
  })
}
