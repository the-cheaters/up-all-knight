$(document).ready(function() {
  var whitePlayersTime = 0
  var blackPlayersTime = 0
  console.log(blackPlayersTime)
  var currentTurn = parseInt($('.game-wrapper').data('current-turn'))
  
  if (currentTurn % 2 === 0) {
    $('.piece').draggable({
      containment: $('.chessboard'),
      grid: [80,80],
      cancel: ".black-piece"
    });
    
  } else {
    $('.piece').draggable({
      containment: $('.chessboard'),
      grid: [80,80],
      cancel: ".white-piece"
    });
    
  }
  $('.tile').droppable({
    drop: movePiece
  });
  
  function timer(data) {
    whitePlayersTime = data.timer.white_time_left
    blackPlayersTime = data.timer.black_time_left
    if (data.current_turn % 2 === 1) {
      var  blackTime = data.timer.black_time_left
      var blackTimer = setInterval(function(blackTime){
        $('#black-player-timer').text(blackTime)
        blackTime -= 1
      },1000)
    } else {
      var  whiteTime = data.timer.white_time_left;
      clearInterval(blackTimer);
      var blackTimer = setInterval(function(blackTime){
        $('#black-player-timer').text(blackTime)
        blackTime -= 1
      },1000);
    }
  }
  
  function movePiece(event, ui) {
    
    $.ajax({
      type: 'PUT',
      url: ui.draggable.data("update-url"),
      dataType: 'json',
      data: { piece: { x_position: $(this).data('column'), y_position: $(this).data('row') }},
      error: function() {
        alert("Invalid Move!")
      },
      success: function(data) {
        timer(data)
      }
    });
  };
  
  
});
