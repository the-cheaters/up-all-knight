$(document).ready(function() {
  $(".player-ready").click(function() {
  var updateURL = $(event.currentTarget).data("update-url");
    $.ajax({
      type: 'PUT',
      url: updateURL
      dataType: 'json',
      data: { current_player: window.player_id  }
    });
  });

  $(".player-not-ready").click(function() {
  var updateURL = $(event.currentTarget).data("update-url");
  var timeLeft = 30;
  var elem = document.getElementById('player_not_ready');

  var timerId = setInterval(countdown, 1,000);

  function countdown() {
    if (timeLeft == 0) {
      clearTimeout(timerId);
    $.ajax({
      type: 'PUT',
      url: updateURL
      dataType: 'json',
      data: { current_player: window.player_id  }
    });
    } else {
      elem.innerHTML = timeLeft + ' seconds remaining';
      timeLeft--;
    }
  }
});
