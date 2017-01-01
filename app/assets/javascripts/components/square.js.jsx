var Square = React.createClass({

  render: function() {
    let color = ""
    if ((this.props.r + this.props.c) % 2 === 0) {
      color = "white tile ui-droppable"
    } else {
      color = "black tile ui-droppable"
    }

    var piece = null
    var key = ""
    var arr = this.props.pieces
    for (var i = 0, len = arr.length; i < len; i++) {
      var x = this.props.c
      var y = this.props.r
      if (arr[i].x_position === x && arr[i].y_position === y) {
        piece = arr[i]
        key = i
       }
    }

    if (piece != null) {
      piece = <Piece r={this.props.r} c={this.props.c} key={piece.id} type={piece.type} color={piece.color}/>
    } else {
      piece = ""
    }
    return (
        <div className={color}>
          {piece}
        </div>
    )
  }
});
