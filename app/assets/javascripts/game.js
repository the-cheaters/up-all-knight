$(document).ready(function() {
  
  var currentPlayer = $('.game-wrapper').data('player')
  
  if (currentPlayer  === "white") {
    $('.piece').draggable({
      containment: $('.chessboard'),
      grid: [80,80],
      cancel: ".black-piece"
    });
    
  } else {
    $('.piece').draggable({
      containment: $('.chessboard'),
      grid: [80,80],
      cancel: ".white-piece"
    });
    
  }
  $('.tile').droppable({
    drop: movePiece
  });
  
  function movePiece(event, ui) {
    
    $.ajax({
      type: 'PUT',
      url: ui.draggable.data("update-url"),
      dataType: 'json',
      data: { piece: { x_position: $(this).data('column'), y_position: $(this).data('row') }},
      error: function() {
        alert("Invalid Move!")
      },
      success:
      
    });
  };
  
  
});
