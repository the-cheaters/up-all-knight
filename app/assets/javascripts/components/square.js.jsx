var Square = React.createClass({

  render: function() {
    let color = ""
    if ((this.props.r + this.props.c) % 2 === 0) {
      color = "white tile"
    } else {
      color = "black tile"
    }
    return (
        <div className={color}>
          <Piece r={this.props.r} c={this.props.c} pieces={this.props.pieces}/>
        </div>
      )
  }
});
