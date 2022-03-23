// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.7;

import "@openzeppelin/contracts/access/Ownable.sol";

contract PersonalWallet {

    address public walletOwner;
    string public walletName;
    mapping (address => uint256) public walletBalance;
    
    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    constructor (){
        walletName = "Family Wallet";
        walletOwner = msg.sender;
        
    }
    function depositMoney(uint256 _value) public payable{
        require(_value !=0,"You should deposit more than zero.");
        walletBalance[msg.sender] += _value;
        
    }

    function setWalletName(string memory _name) external{
        require(msg.sender == walletOwner,"You should be wallet owner");
        walletName = _name;
    }

    function sendMoney(address payable _to, uint256 _total) public{
        require(_total <= walletBalance[msg.sender],"You dont have enough balance to withdraw");
        walletBalance[msg.sender] -= _total;
        _to.transfer(_total);
    }

    function getWalletBalance() external view returns (uint256) {
        return walletBalance[msg.sender];
    }
    function sellwallet(address newOwner) public {
        require(newOwner != address(0));
        require(msg.sender ==walletOwner,"You should be owner to sell the wallet");
        _setOwner(newOwner);
    }
    function _setOwner(address newOwner) private {
        address oldOwner = walletOwner;
        walletOwner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}