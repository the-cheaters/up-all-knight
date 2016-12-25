$(document).ready(function() {
  
  
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
      }
    });
  };
});
