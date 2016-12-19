// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require jquery-ui
//= require turbolinks
//= require_tree .
//= require js-routes

// Enable pusher logging - don't include this in production
Pusher.logToConsole = true;

var pusher = new Pusher('69d78adae1cff6a25019', {
  encrypted: true
});

var channel = pusher.subscribe('my-channel');
channel.bind('my-event', function(data) {
  alert(data.message);
});

window.pusher = new Pusher('69d78adae1cff6a25019');
window.broadcast_channel = pusher.subscribe('broadcast');
