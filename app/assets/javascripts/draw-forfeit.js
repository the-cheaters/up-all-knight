$(function() {
  $(".request-draw").click(function() {
    var updateURL = $(event.currentTarget).data("update-url");
    var updateVar = $(event.currentTarget).data("color") + "_draw";
    $.ajax({
      type: 'PUT',
      url: updateURL,
      dataType: 'json',
      data: { game: { updateVar: true } },
      success: function(data) {
        alert("A draw has been requested!");
      }
    });
  });

  $(".accept-draw").click(function() {
    var updateURL = $(event.currentTarget).data("update-url");
    var updateVar = $(event.currentTarget).data("color") + "_draw";
    $.ajax({
      type: 'PUT',
      url: updateURL,
      dataType: 'json',
      data: { game: { updateVar: true } },
      success: function(data) {
        alert("The draw has been accepted!");
      }
    });
  });

  $(".reject-draw").click(function() {
    var updateURL = $(event.currentTarget).data("update-url");
    var updateVar = $(event.currentTarget).data("color") + "_draw";
    $.ajax({
      type: 'PUT',
      url: updateURL,
      dataType: 'json',
      data: { game: { updateVar: false } },
      success: function(data) {
        alert("The draw has been rejected!");
      }
    });
  });

  $(".forfeit").click(function() {
    var updateURL = $(event.currentTarget).data("update-url");
    var updateVar = $(event.currentTarget).data("color") + "_forfeit";
    $.ajax({
      type: 'PUT',
      url: updateURL,
      dataType: 'json',
      data: { game: { updateVar: true } },
      success: function(data) {
        alert("The draw has been rejected!");
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
    });
  }

});
