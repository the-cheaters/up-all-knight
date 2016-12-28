$(document).ready(function() {
    $(".pawn-promotion").click(function () {
      var piece = $(this).text()
      $.ajax({
        type: 'PUT',
        url: window.pawnPromotionUpdateURL,
        dataType: 'json',
        data: { new_piece: piece}, 
        success: function(data) {
          $('#message').css('display', 'block')
          $('#message').html("Your pawn has been promoted to a " + piece)
        }
      });
    })
  });