$(document).ready(function() {
  var currentPlayer = $('.game-wrapper').data('player')
  var currentPlayersTurn = $('.game-wrapper').data('current-turn')
  var currentTimer = null
  var black_start_time = $('.game-wrapper').data('black-start-time')
  var white_start_time = $('.game-wrapper').data('white-start-time')
  var timeNow = $('.game-wrapper').data('time-now')
  var isBlitz = $('.game-wrapper').data('game-type')
  
  function currentTurn(data, pageload) {
    var blackTime = (data.timer.black_time_left)
    var whiteTime = (data.timer.white_time_left)
    if (pageload === true) {
      if (data.current_turn === "black") {
        var blackElapsed = (timeNow - black_start_time)
        blackTime = (data.timer.black_time_left - blackElapsed)
        $('#black-player-timer').text(blackTime)
        
        $('#white-player-timer').text($('.game-wrapper').data('white-time-left'))
      } else if (data.current_turn === "white") {
        var whiteElapsed = (timeNow - white_start_time)
        whiteTime = (data.timer.white_time_left - whiteElapsed)
        $('#white-player-timer').text(whiteTime)
        $('#black-player-timer').text($('.game-wrapper').data('black-time-left'))
      }
    }
    clearInterval(currentTimer);
    if (data.current_turn === "black") {
      currentTimer = setInterval(function(){
        if (blackTime === 0) {
          clearInterval(currentTimer)
        }
        $('#black-player-timer').text(blackTime)
        blackTime -= 1
      },1000)
    } else {
      currentTimer = setInterval(function(){
        if (whiteTime === 0) {
          clearInterval(currentTimer)
        }
        $('#white-player-timer').text(whiteTime)
        whiteTime -= 1
      },1000);
    }
  };
  
  function disablePieces(currentPlayer, currentPlayersTurn) {
    if (currentPlayer === "black") {
      if (currentPlayersTurn === "black") {
        $('.piece').draggable({
          containment: $('.chessboard'),
          grid: [80,80],
          cancel: ".white-piece"
        });
      } else {
        $('.piece').draggable({
          containment: $('.chessboard'),
          grid: [80,80],
          cancel: ".piece"
        })
      }
    } else if (currentPlayer === "white") {
      
      if (currentPlayersTurn === "white") {
        
        $('.piece').draggable({
          containment: $('.chessboard'),
          grid: [80,80],
          cancel: ".black-piece"
        });
      } else {
        $('.piece').draggable({
          containment: $('.chessboard'),
          grid: [80,80],
          cancel: ".piece"
        })
      }
    }
  }
  
  window.broadcast_channel.bind('change_turns', function(data) {
    if (isBlitz === true){
      currentTurn(data,false)
    }
    $('.current-turn h3').text(data.current_turn + " players turn")
    disablePieces(currentPlayer, data.current_turn)
  });
  
  window.broadcast_channel.bind('pusher:subscription_succeeded', function() {
    if (isBlitz === true){
      var data = {timer: {black_time_left: $('.game-wrapper').data('black-time-left'),white_time_left: $('.game-wrapper').data('white-time-left')}, current_turn: currentPlayersTurn };
      currentTurn(data, true)
    }
    $('.current-turn h3').text(currentPlayersTurn + " players turn")
    disablePieces(currentPlayer, currentPlayersTurn)
  });
  
});
