pragma solidity^0.5.0;

contract Lottery {
    address public manager;
    address public winner;
    address[] public lotteryPlayers;
    uint public roundNum;

    constructor() public {
        manager = msg.sender;
    }

    function throwIn() public payable{
        require(msg.value == 1 ether);
        lotteryPlayers.push(msg.sender);
    }
}