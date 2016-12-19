$(function() {
  $(".request-draw").click(function() {
    var updateURL = $(event.currentTarget).data("update-url");
    var color = $(event.currentTarget).data("color");
    var id = $(event.currentTarget).data("game-id");
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
            url: id+"/draw"
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
            url: id+"/draw"
          });
        }
      });
    }
  });

  $(".accept-draw").click(function() {
    var updateURL = $(event.currentTarget).data("update-url");
    var color = $(event.currentTarget).data("color");
    var id = $(event.currentTarget).data("game-id");
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
            url: id+"/draw"
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
            url: id+"/draw"
          });
        }
      });
    }
  });

  $(".reject-draw").click(function() {
    var updateURL = $(event.currentTarget).data("update-url");
    var color = $(event.currentTarget).data("color");
    var id = $(event.currentTarget).data("game-id");
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
            url: id+"/reject_draw"
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
            url: id+"/reject_draw"
          });
        }
      });
    }
  });

  $(".forfeit").click(function() {
    var updateURL = $(event.currentTarget).data("update-url");
    var color = $(event.currentTarget).data("color");
    var id = $(event.currentTarget).data("game-id");
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
            url: id+"/forfeit"
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
            url: id+"/forfeit"
          });
        }
      });
    }
  });

});
