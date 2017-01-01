import React, { Component, PropTypes } from 'react';
import { ItemTypes } from './Constants';
import { DragSource } from 'react-dnd';

const pieceSource = {
  beginDrag(props) {
    return {};
  }
};

function collect(connect, monitor) {
  return {
    connectDragSource: connect.dragSource(),
    isDragging: monitor.isDragging()
  }
}


class Piece extends Component {

  render() {
    var type = this.props.type
    var color = this.props.color
    const { connectDragSource, isDragging } = this.props;
    var unicodes = {white:{Pawn: "\u2659", Rook: "\u2656", Knight: "\u2658", Bishop: "\u2657", Queen: "\u2655", King: '\u2654' }, black:{Pawn: "\u265F", Rook: "\u265C", Knight: "\u265E", Bishop: "\u265D", Queen: "\u265B", King: "\u265A"}}


    return connectDragSource(
      <div className="piece">   
        {unicodes[color][type]}
      </div>
    );
  }
};

Piece.propTypes = {
  connectDragSource: PropTypes.func.isRequired,
  isDragging: PropTypes.bool.isRequired
};


export default DragSource(ItemTypes.Piece, pieceSource, collect)(Piece);