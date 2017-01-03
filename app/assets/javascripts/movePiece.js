$(document).ready(function() {

  var currentPlayer = $('.game-wrapper').data('player')
  var currentPlayersTurn = $('.game-wrapper').data('current-turn')
  var currentTimer = null
  var black_start_time = $('.game-wrapper').data('black-start-time')
  var white_start_time = $('.game-wrapper').data('white-start-time')
  var timeNow = $('.game-wrapper').data('time-now')
  var isBlitz = $('.game-wrapper').data('game-type')
  var gameStarted = $('.game-wrapper').data('has-started')
  
  function currentTurn(data, pageload) {
    var blackTime = (data.timer.black_time_left)
    var whiteTime = (data.timer.white_time_left)
    
      if (data.current_turn === "black") {
        if (pageload === true) {
        var blackElapsed = (timeNow - black_start_time)
        blackTime = (data.timer.black_time_left - blackElapsed)
        $('#black-player-timer').text(blackTime)
        $('#white-player-timer').text($('.game-wrapper').data('white-time-left'))
        }
          clearInterval(currentTimer);
          currentTimer = setInterval(function(){
            if (blackTime === 0) {
              clearInterval(currentTimer)
            }
            $('#black-player-timer').text(blackTime)
            blackTime -= 1
          },1000)
         
      } else if (data.current_turn === "white") {
        if (pageload === true) {
        var whiteElapsed = (timeNow - white_start_time)
        whiteTime = (data.timer.white_time_left - whiteElapsed)
        $('#black-player-timer').text($('.game-wrapper').data('black-time-left'))
        }
        if (gameStarted === true) {
          $('#white-player-timer').text(whiteTime)
          clearInterval(currentTimer);
          currentTimer = setInterval(function(){
              if (whiteTime === 0) {
                clearInterval(currentTimer)
              }
              $('#white-player-timer').text(whiteTime)
              whiteTime -= 1
            },1000);
           
        } else {
          $('#white-player-timer').text($('.game-wrapper').data('white-time-left'))
          $('#black-player-timer').text($('.game-wrapper').data('black-time-left'))
        } // end of gameStarted === true
        } // end of white turn

  } // end of currentTurn
    
    
  
  
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
    if (isBlitz === true ){
      var data = {timer: {black_time_left: $('.game-wrapper').data('black-time-left'),white_time_left: $('.game-wrapper').data('white-time-left')}, current_turn: currentPlayersTurn };
      currentTurn(data, true)
    }
    $('.current-turn h3').text(currentPlayersTurn + " players turn")
    disablePieces(currentPlayer, currentPlayersTurn)
  });

  window.broadcast_channel.bind('game_has_started', function(data) {
    gameStarted = data.game_has_started
  });

  window.private_channel.bind('move_piece_onscreen', function(data) {
    console.log(data.event)
    $(data.event).html("")
    origin = "#C" + data.piece.original_x + "R" + data.piece.original_y
    destination = "#C" + data.piece.destination_x + "R" + data.piece.destination_y
    originalPositionPiece = $(origin).html()
    $(origin).html("")
    $(destination).html("")
    $(destination).html(originalPositionPiece)
  });
});
