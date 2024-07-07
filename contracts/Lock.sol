// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.24;

// Uncomment this line to use console.log
import "hardhat/console.sol";


contract Lock {

    
    uint public unlockTime;
    address payable public owner;

    event Withdrawal(uint amount, uint when);

    constructor(uint _unlockTime) {
        require(block.timestamp < _unlockTime, "Unlock time should be in the future");
        unlockTime = _unlockTime;
        owner = payable(msg.sender);
    }

    function withdraw() public {
        // Ensure that the transaction is initiated by the owner
        require(msg.sender == owner, "You aren't the owner");
        // Ensure that the current time is greater than or equal to the unlock time
        require(block.timestamp >= unlockTime, "You can't withdraw yet");
        // Emit the withdrawal event
        emit Withdrawal(address(this).balance, block.timestamp);
        // Transfer the balance to the owner
        owner.transfer(address(this).balance);
    }
}

