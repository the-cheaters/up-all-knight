import ReactOnRails from 'react-on-rails';
import HelloWorld from '../components/HelloWorld';
import Piece from '../components/piece';
import Chessboard from '../components/chessboard';
import Square from '../components/square';

// This is how react_on_rails can see the HelloWorld in the browser.
ReactOnRails.register({
  HelloWorld,
  Chessboard,
  Piece,
  Square,
});
