$(function() {
  $(".request-draw").click(function() {
    var updateURL = $(event.currentTarget).data("update-url");
    $.ajax({
      type: 'PUT',
      url: updateURL,
      success: function(data) {
        // success message
      }
    });
  });

  $(".accept-draw").click(function() {
    var updateURL = $(event.currentTarget).data("update-url");
    $.ajax({
      type: 'PUT',
      url: updateURL,
      success: function(data) {
        // success message
      }
    });
  });

  $(".reject-draw").click(function() {
    var updateURL = $(event.currentTarget).data("update-url");
    $.ajax({
      type: 'PUT',
      url: updateURL,
      success: function(data) {
        // success message
      }
    });
  });

  $(".forfeit").click(function() {
    var updateURL = $(event.currentTarget).data("update-url");
    $.ajax({
      type: 'PUT',
      url: updateURL,
      success: function(data) {
        // success message
      }
    });
  });

  function sendMessage() {
    // if there is a message for the user, show it
    $.ajax({
      type: 'PUT',
      // url: 'game_message_path(game_id)', // will have to get game id from somewhere
      success: function(data) {
        // something happens here
      }
  }

  setInterval(sendMessage, 1000); // Timeout
  // Polling request should have timestamp and ask server if anything has changed since that time

});
