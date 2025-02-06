// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MarketplaceToken is ERC20 {
    address public lastSender;
    address public lastReceiver;
    uint256 public lastTimestamp;

    event TransactionTracked(address indexed sender, address indexed receiver, uint256 timestamp);

    constructor(uint256 initialSupply) ERC20("Marketplace Token", "MT") {
        _mint(msg.sender, initialSupply * (10 ** decimals()));
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        bool success = super.transfer(recipient, amount);
        if (success) {
            lastSender = msg.sender;
            lastReceiver = recipient;
            lastTimestamp = block.timestamp;
            emit TransactionTracked(msg.sender, recipient, lastTimestamp);
        }
        return success;
    }

    function balanceOf(address account) public view override returns (uint256) {
        uint256 balance = super.balanceOf(account);
        return balance > 0 ? balance : 0;
    }

    function getLastTransactionTimestamp() public view returns (uint256) {
        return lastTimestamp; // Direct UNIX timestamp for better compatibility
    }

    function getLastSenderAddress() public view returns (address) {
        return lastSender;
    }

    function getLastReceiverAddress() public view returns (address) {
        return lastReceiver;
    }
}