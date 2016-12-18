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
          $.ajax({
            type: 'PUT',
            url: Routes.game_draw_path(game_id)
          });
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
          $.ajax({
            type: 'PUT',
            url: Routes.game_draw_path(game_id)
          });
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
          $.ajax({
            type: 'PUT',
            url: Routes.game_draw_path(game_id)
          });
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
          $.ajax({
            type: 'PUT',
            url: Routes.game_draw_path(game_id)
          });
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
          $.ajax({
            type: 'PUT',
            url: Routes.game_reject_draw_path(game_id)
          });
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
          $.ajax({
            type: 'PUT',
            url: Routes.game_reject_draw_path(game_id)
          });
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
          $.ajax({
            type: 'PUT',
            url: Routes.game_forfeit_path(game_id)
          });
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
          $.ajax({
            type: 'PUT',
            url: Routes.game_forfeit_path(game_id)
          });
        }
      });
    }
  });

});
