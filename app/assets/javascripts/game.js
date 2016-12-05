$(document).ready(function() {
  function move_piece(url,new_x_position,new_y_position) {
    $.ajax({
      type: 'PUT',
      url: url,
      dataType: 'json',
      data: { piece: { x_position: new_x_position, y_position: new_y_position } },
      error: function() {
        alert("Invalid Move!!! Try Again")
      },
      success: function() {
        window.location.reload()
      }
    });
  }
  var  update_url = "";
  var click_number = 0;
  
  $('.tile').click(function() {
    click_number += 1
    if (click_number === 1) {
      update_url = $(this).children( ".piece" ).attr('data-update-url');
      $(this).toggleClass("selected_piece");
    }
    if (click_number === 2){
      click_number = 0
      var x = $(this).attr('data-column');
      var y = $(this).attr('data-row');
      move_piece(update_url,x,y);
      $('div').removeClass("selected_piece")
    }
  });
  
});
