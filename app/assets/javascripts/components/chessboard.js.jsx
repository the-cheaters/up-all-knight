var Chessboard = React.createClass({

  getInitialState() { 
    return { pieces: {} } 
  }, 
  componentDidMount() { 
    $.getJSON('/api/v1/pieces.json',{game: window.game_id}, (response) => { this.setState({ pieces: response }) }); 
  },


  render: function() { 

    function key(r,c) {
      return (r + c * Math.random())
    }
    var squares = [];
    for (var row = 0; row < 8; row++) {
      for (var column = 0; column < 8; column++) {
       squares.push(<Square c={column} r={row} key={key(row,column)} pieces={this.state.pieces} />)
      }   
    }
    return (  
          <div>
          {squares} 
          </div>
        );
  }
});
