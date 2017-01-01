var Piece = React.createClass({

  render: function() {
    var type = this.props.type
    var color = this.props.color
    
    var unicodes = {white:{Pawn: "\u2659", Rook: "\u2656", Knight: "\u2658", Bishop: "\u2657", Queen: "\u2655", King: '\u2654' }, black:{Pawn: "\u265F", Rook: "\u265C", Knight: "\u265E", Bishop: "\u265D", Queen: "\u265B", King: "\u265A"}}


    return (
      <div className="piece">   
        {unicodes[color][type]}
      </div>
    );
  }
});
