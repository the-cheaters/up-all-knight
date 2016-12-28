$(document).ready(function() {
  $("#player-ready").click(function() {
    $.ajax({
      type: 'PUT',
      url: $("#player-ready").data("update-url"),
      dataType: 'json',
      data: { current_player: window.player_id  }
    });
  });
  var timerId = null
  window.broadcast_channel.bind('start_ready_timer', function(data) {
  
  var updateURL = $(event.currentTarget).data("update-url");
  var timeLeft = 30;
  var elem = $('.ready-timer');

  timerId = setInterval(countdown, 1000);

    function countdown() {
      if (timeLeft == 0) {
        clearTimeout(timerId);
      $.ajax({
        type: 'PUT',
        url: $(event.currentTarget).data("player_not_ready"),
        dataType: 'json',
        data: { current_player: window.player_id  }
      });
      } else {
        elem.innerHTML = timeLeft + ' seconds remaining until you forfeit';
        timeLeft--;
      }
    }
  });
  window.broadcast_channel.bind('hide_not_ready_buttons', function(data) {
    $('#player-ready').css('display', 'none')
  });
  window.broadcast_channel.bind('clear_ready_timer', function(data) {
    clearTimeout(timerId);
  });
});
