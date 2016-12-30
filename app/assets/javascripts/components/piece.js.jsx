var Piece = React.createClass({

  render: function() {
  var piece = ""
  this.props.pieces.map(function(piece) {
    var x = this.props.c
    var y = this.props.r
    if (piece.x_position === x && piece.y_position === y) {
      piece = piece
    }
  });


    return (
      <div className="piece">
        {piece.type}
      </div>
    );
  }
});
