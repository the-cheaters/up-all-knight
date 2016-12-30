var Chessboard = React.createClass({



  render: function() { 

    function key(r,c) {
      return (r + c * Math.random())
    }
    var squares = [];
    for (var row = 0; row < 8; row++) {
      for (var column = 0; column < 8; column++) {
       squares.push(<Square c={column} r={row} key={key(row,column)} />)
      }   
    }
    return (  
          <div>
          {squares} 
          </div>
        );
  }
});
