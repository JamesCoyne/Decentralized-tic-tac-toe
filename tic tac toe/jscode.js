Web3 = require('web3');
web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));

//abi = JSON.parse('[{"constant":false,"inputs":[],"name":"getBoard","outputs":[{"name":"","type":"uint256[]"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"input","type":"uint256[]"}],"name":"makeMove2","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"x","type":"uint256"},{"name":"y","type":"uint256"},{"name":"value","type":"uint256"}],"name":"makeMove","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"inputs":[],"payable":false,"stateMutability":"nonpayable","type":"constructor"}]');
//var abi = JSON.parse(require("abi.json"));
abi = JSON.parse('[{"constant":false,"inputs":[],"name":"getBoard","outputs":[{"name":"","type":"uint256[]"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[],"name":"resetBoard","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[],"name":"checkWinner","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"input","type":"uint256[]"}],"name":"makeMove","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"inputs":[],"payable":false,"stateMutability":"nonpayable","type":"constructor"}]');
TicTacToeContract = web3.eth.contract(abi);

var address = '';

function getboard(){
  contractInstance = TicTacToeContract.at(address);
  contractInstance.getBoard({from: web3.eth.accounts[0]}, function() {
    var board =  contractInstance.getBoard.call();
    console.log(board);

    for(var i = 0; i < 9; i++){
          var div_id = "#cell" + i;
          if(board[i].c.toString() == '1'){
            $(div_id).html('x');
          }
          else if(board[i].c.toString() == '2'){
            $(div_id).html('o');
          }
          else if(board[i].c.toString() == '0'){
            $(div_id).html(' ');
          }
          else $(div_id).html(board[i].c.toString());
    }
  });
}

function getWinner(){
  contractInstance = TicTacToeContract.at(address);
  contractInstance.checkWinner({from: web3.eth.accounts[0]}, function() {
    $("#winner").html(contractInstance.checkWinner.call().toString());
    console.log(contractInstance.checkWinner.call().toString());
  });
}

function resetBoard(){
  contractInstance = TicTacToeContract.at(address);
  contractInstance.resetBoard({from: web3.eth.accounts[0]}, function() {
    contractInstance.checkWinner.call();
  });
}

function setAddress(){
  address = document.getElementById("address").value;
  console.log(address);
}

//currently this doesn't work
function makemove(x, y){
  contractInstance = TicTacToeContract.at(address);
  contractInstance.makeMove([x,y,document.getElementById("user").value],{from: web3.eth.accounts[0]}, function() {
    $("#turn").html(contractInstance.makeMove.call().toString());
    console.log(contractInstance.makeMove.call().toString());
  });
  getboard();
  getWinner();
}

function testArgIn(){
  contractInstance = TicTacToeContract.at(address);
  console.log(contractInstance.testArgIn(['1','2','3'],{from: web3.eth.accounts[0]}, function() {
  }));
}


$(document).ready(function() {
  if(address != '') getboard();
});
