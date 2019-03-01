pragma solidity^0.5.0;

contract Lottery {
    address payable manager;
    address payable winner;
    address payable [] lotteryPlayers;
    uint public winningNum;
    uint public roundNum;
    uint public rewardRate=80;
    uint public winningReward;

    constructor() public {
        manager = msg.sender;
    }

    function throwIn() public payable{
        require(msg.value == 1 ether);
        lotteryPlayers.push(msg.sender);
    }

    modifier managerLimit {
        require(msg.sender == manager);
        _;
    }

    //event test(uint,uint);
    function draw() public managerLimit  {
        require(lotteryPlayers.length != 0);
        bytes memory randomInfo = abi.encodePacked(now,block.difficulty,lotteryPlayers.length);
        bytes32 randomHash =keccak256(randomInfo);
        winningNum = uint(randomHash)%lotteryPlayers.length;
        winner=lotteryPlayers[winningNum];

        winningReward = address(this).balance*rewardRate/100;
        winner.transfer(winningReward);
        //emit test(reward,address(this).balance);
        manager.transfer(address(this).balance);
        roundNum++;
        delete lotteryPlayers;
    }
    function getBalance()public view returns(uint){
        return address(this).balance;
    }
    function getWinner()public view returns(address){
        return winner;
    }
    function getManager()public view returns(address){
        return manager;
    }

}