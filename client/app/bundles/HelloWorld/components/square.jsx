import React, { PropTypes } from 'react';
import Piece from './piece';
import { ItemTypes } from './Constants';
import { DropTarget } from 'react-dnd';

const squareTarget = {
  drop(props) {
    alert("you moved a piece" + props);
  }
};

function collect(connect, monitor) {
  return {
    connectDropTarget: connect.dropTarget(),
    isOver: monitor.isOver()
  };
}
class Square extends React.Component {

  render() {
    const {connectDropTarget, isOver } = this.props;
    let color = ""
    if ((this.props.r + this.props.c) % 2 === 0) {
      color = "white tile"
    } else {
      color = "black tile"
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
    return connectDropTarget(
        <div className={color}>
          {piece}
        </div>
    )
  }
};

export default DropTarget(ItemTypes.Piece, squareTarget, collect)(Square);