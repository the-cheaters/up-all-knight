$ ->
  window.broadcast_channel.bind 'draw_forfeit', (event) ->
    $('#message').css('display', 'block')
    $('#message').html(event.message)

$ ->
  window.broadcast_channel.bind 'show_default_button', (event) ->
    $('#button-panel').html('<button class="request-draw" data-update-url="<%= game_path(@game) %>" data-color="<%= @color %>" data-game-id="<%= @game.id %>">Request Draw</button>')

$ ->
  window.broadcast_channel.bind 'show_draw_response_buttons', (event) ->
    $('#button-panel').html('<button class="accept-draw" data-update-url="<%= game_path(@game) %>" data-color="<%= @color %>" data-game-id="<%= @game.id %>">Accept Draw</button><br/><button class="reject-draw" data-update-url="<%= game_path(@game) %>" data-color="<%= @color %>">Reject Draw</button>')

$ ->
  window.broadcast_channel.bind 'show_forfeit_button', (event) ->
    $('#button-panel').html('<button class="forfeit" data-update-url="<%= game_path(@game) %>" data-color="<%= @color %>" data-game-id="<%= @game.id %>">Forfeit</button>')
