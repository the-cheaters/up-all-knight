$ ->
  window.broadcast_channel.bind 'draw_forfeit', (event) ->
    $('#message').css('display', 'block')
    $('#message').html(event.message)

  window.broadcast_channel.bind 'hide_buttons', (event) ->
    $('.request-draw').css('display', 'none')
    $('.accept-draw').css('display', 'none')
    $('.reject-draw').css('display', 'none')
    $('.forfeit').css('display', 'none')

  window.private_channel.bind 'show_default_button', (event) ->
    $('.request-draw').css('display', 'inline')
    $('.accept-draw').css('display', 'none')
    $('.reject-draw').css('display', 'none')
    $('.forfeit').css('display', 'none')

  window.private_channel.bind 'hide_buttons', (event) ->
    $('.request-draw').css('display', 'none')
    $('.accept-draw').css('display', 'none')
    $('.reject-draw').css('display', 'none')
    $('.forfeit').css('display', 'none')

  window.private_channel.bind 'show_draw_response_buttons', (event) ->
    $('.request-draw').css('display', 'none')
    $('.accept-draw').css('display', 'inline')
    $('.reject-draw').css('display', 'inline')

  window.private_channel.bind 'show_forfeit_button', (event) ->
    $('.forfeit').css('display', 'inline')

  window.broadcast_channel.bind 'start_timer', (event) ->

    console.log event
    timer(event)


  currentTimer = null

  currentTurn = (whoseTurn) ->
    clearInterval currentTimer
    if whoseTurn == 'black'
      blackTime = $('.game-wrapper').data('black-time-left')
      currentTimer = setInterval((->
        if blackTime == 0
          clearInterval currentTimer
        $('#black-player-timer').text blackTime
        blackTime -= 1
        return
      ), 1000)
    else
      whiteTime = $('.game-wrapper').data('white-time-left')
      currentTimer = setInterval((->
        if whiteTime == 0
          clearInterval currentTimer
        $('#white-player-timer').text whiteTime
        whiteTime -= 1
        return
      ), 1000)
    return


  window.broadcast_channel.bind 'pusher:subscription_succeeded', (event) ->
    whoseTurn = $('.game-wrapper').data('current-turn')
    currentTimer = null
    currentTurn whoseTurn

currentTurn = (whoseTurn) ->
  clearInterval currentTimer
  if whoseTurn == 'black'
    blackTime = $('.game-wrapper').data('black-time-left')
    currentTimer = setInterval((->
      if blackTime == 0
        clearInterval currentTimer
      $('#black-player-timer').text blackTime
      blackTime -= 1
      return
    ), 1000)
  else
    whiteTime = $('.game-wrapper').data('white-time-left')
    currentTimer = setInterval((->
      if whiteTime == 0
        clearInterval currentTimer
      $('#white-player-timer').text whiteTime
      whiteTime -= 1
      return
    ), 1000)
  currentPlayer = $('.game-wrapper').data('player')
  if currentPlayer == 'white'
    $('.piece').draggable
      containment: $('.chessboard')
      grid: [
        80
        80
      ]
      cancel: '.black-piece'
  else
    $('.piece').draggable
      containment: $('.chessboard')
      grid: [
        80
        80
      ]
      cancel: '.white-piece'
  return
