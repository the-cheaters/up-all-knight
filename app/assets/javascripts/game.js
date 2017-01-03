$(document).ready(function() {
  
  
  $('.tile').droppable({
    drop: movePiece
  });
  
  function movePiece(event, ui) {
    $(event.target.id).html("")
    $.ajax({
      type: 'PUT',
      url: ui.draggable.data("update-url"),
      dataType: 'json',
      data: { piece: { x_position: $(this).data('column'), y_position: $(this).data('row') }, event: event.target.id},
      error: function() {
        console.log("error: reload window")
        window.location.reload()
      }
    });
  };
});
