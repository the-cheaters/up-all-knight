$(document).ready(function() {
  window.broadcast_channel.bind('move_piece_onscreen', function(data) {
    currentLocation = "#C" + data.x_position + "R" + data.y_position
    destination = "#C" + data.destination_x + "R" + data.destination_y
    $(currentLocation).children(".piece").html("")
    $(destination).children(".piece").html(data.symbol)
  })
});
