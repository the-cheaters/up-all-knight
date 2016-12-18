// Draw and forfeit actions

$ ->
  window.broadcast_channel.bind 'draw_forfeit', (event) ->
    $('#message').html(event.message)

// Show default buttons

$ ->
  window.broadcast_channel.bind 'show_default_button', (event) ->
    $('#button-panel').html('<button class="request-draw" data-update-url="<%= game_path(@game) %>" data-color="<%= @color %>">Request Draw</button>')

// Show draw choice buttons

$ ->
  window.broadcast_channel.bind 'show_draw_response_buttons', (event) ->
    $('#button-panel').html('<button class="accept-draw" data-update-url="<%= game_path(@game) %>" data-color="<%= @color %>">Accept Draw</button><br/><button class="reject-draw" data-update-url="<%= game_path(@game) %>" data-color="<%= @color %>">Reject Draw</button>')

// Show forfeit button

$ ->
  window.broadcast_channel.bind 'show_forfeit_button', (event) ->
    $('#button-panel').html('<button class="forfeit" data-update-url="<%= game_path(@game) %>" data-color="<%= @color %>">Forfeit</button>')
