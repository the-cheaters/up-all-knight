var Chessboard = React.createClass({

  render: function() { 
    return (
      <div className={this.props.color + " tile"}>
        <Piece />
      </div>
    );
  }
});
