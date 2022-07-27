//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract Lottery{

    uint public minFee;
    address public owner;
    address[] players;
    mapping(address => uint) public playerBalances;
    event newPlayer(
        address indexed player,
        uint fee
    )
    ;

    constructor(uint _minFee){
        minFee = _minFee;
        owner = msg.sender;
    }

    function play() public payable minFeePay{
        players.push((msg.sender));
        playerBalances[msg.sender] += msg.value;
        emit newPlayer(msg.sender, msg.value);
    }

    function getBalance()public view returns(uint){
        return address(this).balance;
    }

    function getRandomNumber()public view returns(uint){
        return uint(keccak256(abi.encodePacked(owner, block.timestamp)));
    }

    function pickWinner() public onlyOwner{
        uint index = getRandomNumber() % players.length;
        (bool success,) = players[index].call{value:getBalance()}("");
        require(success,"Pago fallo");
        players = new address [](0);
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    modifier minFeePay(){
        require(msg.value >= minFee,"Necesitas pagar mas");
        _;
    }


}