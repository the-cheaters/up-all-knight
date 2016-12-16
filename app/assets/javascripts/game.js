$(document).ready(function() {
  var x = 0;
  var y = 0;
  $('.piece').draggable({
    containment: $('.chessboard'),
    grid: [80,80],
  });
  
  $('.tile').droppable({
    drop: movePiece
  });
  
  function movePiece(event, ui) {
    
    $.ajax({
      type: 'PUT',
      url: ui.draggable.data("update-url"),
      dataType: 'json',
      data: { piece: { x_position: $(this).data('column'), y_position: $(this).data('row') } },
      error: function() {
        alert("Invalid Move!")
      },
      success: function () {
        
      }
    });
  };
});
