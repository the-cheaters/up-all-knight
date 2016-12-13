$(function() {
  $(".request-draw").click(function() {
    var updateURL = $(event.target).data("update-url");
    $.ajax({
      type: 'PUT',
      url: updateURL,
      success: function(data) {
        // success message
      }
    });
  });

  $(".accept-draw").click(function() {
    var updateURL = $(event.target).data("update-url");
    $.ajax({
      type: 'PUT',
      url: updateURL,
      success: function(data) {
        // success message
      }
    });
  });

  $(".reject-draw").click(function() {
    var updateURL = $(event.target).data("update-url");
    $.ajax({
      type: 'PUT',
      url: updateURL,
      success: function(data) {
        // success message
      }
    });
  });

  $(".forfeit").click(function() {
    var updateURL = $(event.target).data("update-url");
    $.ajax({
      type: 'PUT',
      url: updateURL,
      success: function(data) {
        // success message
      }
    });
  });

  function showMessage() {
    // if there is a message for the user, show it
  }

  setInterval(showMessage, 1000);

});
