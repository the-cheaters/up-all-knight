$(document).ready(function() {
    $("#Queen-promotion").click(function () {
      $.ajax({
        type: 'PUT',
        url: window.pawnPromotionUpdateURL,
        dataType: 'json',
        data: { new_piece: "Queen"}, 
        success: function(data) {
          $('#message').css('display', 'block')
          $('#message').html("Your pawn has been promoted to a Queen")
        }
      });
    })
    $("#Rook-promotion").click(function () {
      $.ajax({
        type: 'PUT',
        url: window.pawnPromotionUpdateURL,
        dataType: 'json',
        data: { new_piece: "Rook"}, 
        success: function(data) {
          $('#message').css('display', 'block')
          $('#message').html("Your pawn has been promoted to a Rook")
        }
      });
    })
    $("#Knight-promotion").click(function () {
      $.ajax({
        type: 'PUT',
        url: window.pawnPromotionUpdateURL,
        dataType: 'json',
        data: { new_piece: "Knight"}, 
        success: function(data) {
          $('#message').css('display', 'block')
          $('#message').html("Your pawn has been promoted to a Knight")
        }
      });
    })
    $("#Bishop-promotion").click(function () {
      $.ajax({
        type: 'PUT',
        url: window.pawnPromotionUpdateURL,
        dataType: 'json',
        data: { new_piece: "Bishop"}, 
        success: function(data) {
          $('#message').css('display', 'block')
          $('#message').html("Your pawn has been promoted to a Bishop")
        }
      });
    })
  });