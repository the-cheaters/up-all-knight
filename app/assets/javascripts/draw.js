$(function() {
  $(".request-draw").click(function() {
    var updateURL = $(event.target).data("update-url");
    $.ajax({
      type: 'PUT',
      url: updateURL,
      success: function(data) {
        if (data.error) {
          alert(data.error);
        } else {
          alert("You have successfully requested a draw!");
        }
      }
    })
  });
});

$(function() {
  $(".accept-draw").click(function() {
    var updateURL = $(event.target).data("update-url");
    $.ajax({
      type: 'PUT',
      url: updateURL,
      success: function(data) {
        if (data.error) {
          alert(data.error);
        } else {
          alert("You have accepted the draw. The game is now over.");
        }
      }
    })
  });
});

$(function() {
  $(".reject-draw").click(function() {
    var updateURL = $(event.target).data("update-url");
    $.ajax({
      type: 'PUT',
      url: updateURL,
      success: function(data) {
        alert("You have successfully rejected the draw!");
      }
    })
  });
});

$(function() {
  $(".forfeit").click(function() {
    var updateURL = $(event.target).data("update-url");
    $.ajax({
      type: 'PUT',
      url: updateURL,
      success: function(data) {
        alert("You have successfully forfeited the game.");
      }
    })
  });
});
