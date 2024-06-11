// SPDX-License-Identifier: UNLICENSED
// Your code here

pragma solidity ^0.8.13;

contract Derivatives {
    address public buyer;
    address public seller;

    uint256 public balance;

    error InvalidAccount();
    error ZeroAmount();

    struct Forward {
        address underlyingAsset;
        uint256 quantity;
        uint256 strike;
        uint256 maturity;
        uint256 premium;
        
    }

    function createForward(
    ) public {
        revert InvalidAccount();
    }

    function setBuyer(address _buyer) public {
        if (seller == _buyer) {
            revert InvalidAccount();
        }
        buyer = _buyer;
    }

    function setSeller(address _seller) public {
        if (buyer == _seller) {
            revert InvalidAccount();
        }
        seller = _seller;
    }

    function fund() public payable {
        if (msg.value == 0) {
            revert ZeroAmount();
        }
        balance += msg.value;
    }

    function withdraw(uint256 amount) public {
        balance -= amount;
        payable(msg.sender).transfer(amount);
    }
}