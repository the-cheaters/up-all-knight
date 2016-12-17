$(function() {
  $(".request-draw").click(function() {
    var updateURL = $(event.currentTarget).data("update-url");
    var color = $(event.currentTarget).data("color");
    if (color == "black") {
      $.ajax({
        type: 'PUT',
        url: updateURL,
        dataType: 'json',
        data: { game: { black_draw: true } },
        success: function(data) {
          alert("A draw has been requested!");
        }
      });
    } else if (color == "white") {
      $.ajax({
        type: 'PUT',
        url: updateURL,
        dataType: 'json',
        data: { game: { white_draw: true } },
        success: function(data) {
          alert("A draw has been requested!");
        }
      });
    }
  });

  $(".accept-draw").click(function() {
    var updateURL = $(event.currentTarget).data("update-url");
    var color = $(event.currentTarget).data("color");
    if (color == "black") {
      $.ajax({
        type: 'PUT',
        url: updateURL,
        dataType: 'json',
        data: { game: { black_draw: true } },
        success: function(data) {
          alert("A draw has been requested!");
        }
      });
    } else if (color == "white") {
      $.ajax({
        type: 'PUT',
        url: updateURL,
        dataType: 'json',
        data: { game: { white_draw: true } },
        success: function(data) {
          alert("The draw has been accepted!");
        }
      });
    }
  });

  $(".reject-draw").click(function() {
    var updateURL = $(event.currentTarget).data("update-url");
    var color = $(event.currentTarget).data("color");
    if (color == "black") {
      $.ajax({
        type: 'PUT',
        url: updateURL,
        dataType: 'json',
        data: { game: { black_draw: false } },
        success: function(data) {
          alert("The draw has been rejected!");
        }
      });
    } else if (color == "white") {
      $.ajax({
        type: 'PUT',
        url: updateURL,
        dataType: 'json',
        data: { game: { white_draw: false } },
        success: function(data) {
          alert("The draw has been rejected!");
        }
      });
    }
  });

  $(".forfeit").click(function() {
    var updateURL = $(event.currentTarget).data("update-url");
    var color = $(event.currentTarget).data("color");
    if (color == "black") {
      $.ajax({
        type: 'PUT',
        url: updateURL,
        dataType: 'json',
        data: { game: { black_forfeit: true } },
        success: function(data) {
          alert("The game has been forfeited!");
        }
      });
    } else if (color == "white") {
      $.ajax({
        type: 'PUT',
        url: updateURL,
        dataType: 'json',
        data: { game: { white_forfeit: true } },
        success: function(data) {
          alert("The game has been forfeited!");
        }
      });
    }
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
