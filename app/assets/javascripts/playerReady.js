$(document).ready(function() {
  $("#player-ready").click(function() {
    $.ajax({
      type: 'PUT',
      url: $("#player-ready").data("update-url"),
      dataType: 'json',
      data: { current_player: window.player_id  }
    });
  });
  var timerId = null;
  window.private_channel.bind('start_ready_timer', function(data) {
    var updateURL = $(event.currentTarget).data("update-url");
    var timeLeft = 30;

    timerId = setInterval(countdown, 1000);

      function countdown() {
        $('.ready-timer').text(timeLeft + ' seconds remaining until you forfeit') 
        if (timeLeft === 0) {
          clearTimeout(timerId);
        $.ajax({
          type: 'PUT',
          url: $("#player-ready").data('player-not-ready-url'),
          dataType: 'json',
          data: { current_player: window.player_id  }
        });
        } else {
          timeLeft--;
          
        }
      }
  });
  window.broadcast_channel.bind('hide_ready_buttons', function(data) {
    console.log("hide_not_ready_buttons")
    $('#player-ready').css('display', 'none')
    $('.ready-timer').css('display', 'none')
  });
  window.broadcast_channel.bind('clear_ready_timer', function(data) {
    console.log("inside_clear_timer_ready")
    clearTimeout(timerId);
  });
});
