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
