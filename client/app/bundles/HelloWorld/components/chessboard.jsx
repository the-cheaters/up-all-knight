import React, { PropTypes } from 'react';
import Square from './square';
import { DragDropContext } from 'react-dnd';
import HTML5Backend from 'react-dnd-html5-backend';

class Chessboard extends React.Component {

constructor(props, _railsContext) {
    super(props);

    // How to set initial state in ES6 class syntax
    // https://facebook.github.io/react/docs/reusable-components.html#es6-classes
    this.state = { pieces: {} };
  }
  componentDidMount() { 
    $.getJSON('/api/v1/pieces.json',{game: window.game_id}, (response) => { this.setState({ pieces: response }) }); 
  }

  render(){ 

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
};

export default DragDropContext(HTML5Backend)(Chessboard);