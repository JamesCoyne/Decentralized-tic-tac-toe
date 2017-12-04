pragma solidity ^0.4.11;

contract TicTacToe {

    uint[] private board = new uint[](9);
    uint winner = 0;
    uint turn = 1;

    function TicTacToe() {
      for(uint x = 0; x < 3; x++) {
        for(uint y = 0; y < 3; y++) {
          board[flat(x,y)] = 0;
        }
      }
    }


    function makeMove(uint[] input) public returns(string){
      uint x = input[0];
      uint y = input[1];

      uint v = input[2];
      if(v == turn){
        if(checkValid(x,y)) {
         board[flat(x, y)] = v;

          if(turn == 1){
            turn = 2;
          }
          else if(turn == 2){
            turn = 1;
          }
          else {
            turn = 1;
          }
          return "valid move, nice job";
        }
        return "invalid move, try again";
      }
      else{
        return "it is not your turn";
      }
    }

    function checkWinner() public returns(uint) {
      
      if(
        ((board[flat(0, 0)] == 1) && (board[flat(0, 1)] == 1) && (board[flat(0, 2)] == 1))
        || ((board[flat(1, 0)] == 1) && (board[flat(1, 1)] == 1) && (board[flat(1, 2)] == 1))
        || ((board[flat(2, 0)] == 1) && (board[flat(2, 1)] == 1) && (board[flat(2, 2)] == 1))
        || ((board[flat(0, 0)] == 1) && (board[flat(1, 0)] == 1) && (board[flat(2, 0)] == 1))
        || ((board[flat(0, 1)] == 1) && (board[flat(1, 1)] == 1) && (board[flat(2, 1)] == 1))
        || ((board[flat(0, 2)] == 1) && (board[flat(1, 2)] == 1) && (board[flat(2, 2)] == 1))
        || ((board[flat(0, 0)] == 1) && (board[flat(1, 1)] == 1) && (board[flat(2, 2)] == 1))
        || ((board[flat(0, 2)] == 1) && (board[flat(1, 1)] == 1) && (board[flat(2, 0)] == 1))
      ) {
          winner = 1;
          return 1;
        }
        else if(
        ((board[flat(0, 0)] == 2) && (board[flat(0, 1)] == 2) && (board[flat(0, 2)] == 2))
        || ((board[flat(1, 0)] == 2) && (board[flat(1, 1)] == 2) && (board[flat(1, 2)] == 2))
        || ((board[flat(2, 0)] == 2) && (board[flat(2, 1)] == 2) && (board[flat(2, 2)] == 2))
        || ((board[flat(0, 0)] == 2) && (board[flat(1, 0)] == 2) && (board[flat(2, 0)] == 2))
        || ((board[flat(0, 1)] == 2) && (board[flat(1, 1)] == 2) && (board[flat(2, 1)] == 2))
        || ((board[flat(0, 2)] == 2) && (board[flat(1, 2)] == 2) && (board[flat(2, 2)] == 2))
        || ((board[flat(0, 0)] == 2) && (board[flat(1, 1)] == 2) && (board[flat(2, 2)] == 2))
        || ((board[flat(0, 2)] == 2) && (board[flat(1, 1)] == 2) && (board[flat(2, 0)] == 2))
      ) {
          winner = 2;
          return 2;
        }
        else 
        {
          winner = 0;
          return 0;
        }
    }

    function checkValid(uint x, uint y) private returns(bool) {
        if(board[flat(x, y)] == 0) {
          return true;
        } else {
          return false;
        }
    }

    function getBoard() public returns(uint[]) {
     return board;
    }

    function resetBoard() public {
      if(winner != 0){
      for(uint x = 0; x < 3; x++) {
        for(uint y = 0; y < 3; y++) {
          board[flat(x,y)] = 0;
        }
      }
      winner = 0;
      }
    }

    function flat(uint x, uint y) private returns(uint) {
        return (x + y*3);
    }
}
