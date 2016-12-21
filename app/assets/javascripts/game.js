$(document).ready(function() {
  
  var currentPlayer = $('.game-wrapper').data('player')
  
  if (currentPlayer  === "white") {
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
  var currentTimer = null
  function timer(data) {
    clearInterval(currentTimer);
    
    if (data.current_turn % 2 === 1) {
      var blackTime = data.timer.black_time_left
      
      currentTimer = setInterval(function(){
        if (blackTime === 0) {
          clearInterval(currentTimer)
        }
        $('#black-player-timer').text(blackTime)
        blackTime -= 1
      },1000)
    } else {
      var  whiteTime = data.timer.white_time_left
      currentTimer = setInterval(function(){
        if (whiteTime === 0) {
          clearInterval(currentTimer)
        }
        $('#white-player-timer').text(whiteTime)
        whiteTime -= 1
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
      }
    });
  };
  
  
});
