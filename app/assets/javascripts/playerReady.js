$(document).ready(function() {
  $(".player-ready").click(function() {
  var updateURL = $(event.currentTarget).data("update-url");
  var id = $(event.currentTarget).data("color")
  var playerReady = $('.game-wrapper').data("game-player_ready");
  if (color == "white")  
    $.ajax({
      type: 'PUT',
      url: updateURL
      dataType: 'json',
      data: { player: { white_ready: true} },
      success: function(data) {
        alert("White Player is ready to start blitz chess.");
        $.ajax({
          type: 'PUT',
          url: id+"/player_ready"
        });
      }
    });
  } else if (color == "black") {
    $.ajax({
      type: 'PUT'
      url: updateURL,
      dataType: 'json',
      data: { player: { black_ready: true } },
      success: function(data) {
        alert("Black Player is ready to start blitz chess.");
        $.ajax({
          type: 'PUT',
          url: id+"/player_ready"
        });
      }
    });
  }
});

  $(".player-not-ready").click(function() {
  var updateURL = $(event.currentTarget).data("update-url");
  var id = $(event.currentTarget).data("color")
  var playerNotReady = $('.game-wrapper').data("game-player_not_ready");
  if (color == "white")  
    $.ajax({
      type: 'PUT',
      url: updateURL
      dataType: 'json',
      data: { player: { white_ready: false} },
      success: function(data) {
        alert("White Player is not ready to start blitz chess.");
        $.ajax({
          type: 'PUT',
          url: id+"/player_not_ready"
        });
      }
    });
  } else if (color == "black") {
    $.ajax({
      type: 'PUT'
      url: updateURL,
      dataType: 'json',
      data: { player: { black_ready: false } },
      success: function(data) {
        alert("Black Player is not ready to start blitz chess.");
        $.ajax({
          type: 'PUT',
          url: id+"/player_not_ready"
        });
      }
    });
  }
});

