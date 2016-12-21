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
    currentTimer = null
    console.log event
  timer = (event) ->
    clearInterval currentTimer
    if data.current_turn % 2 == 1
      blackTime = data.timer.black_time_left
      currentTimer = setInterval((->
        if blackTime == 0
          clearInterval currentTimer
        $('#black-player-timer').text blackTime
        blackTime -= 1
        return
      ), 1000)
    else
      whiteTime = data.timer.white_time_left
      currentTimer = setInterval((->
        if whiteTime == 0
          clearInterval currentTimer
        $('#white-player-timer').text whiteTime
        whiteTime -= 1
        return
      ), 1000)
    return
