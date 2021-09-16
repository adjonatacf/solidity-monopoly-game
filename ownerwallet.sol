// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract OwnerWallet {  
  mapping (address => uint) public ownerMoney;

  function _ownerAddMoney(uint _money) internal returns (uint) {
    ownerMoney[msg.sender] += _money;
    return ownerMoney[msg.sender];
  }

  function _ownerDecreaseMoney(uint _money) internal returns (uint) {
    uint _previewMoney = ownerMoney[msg.sender] - _money;

    if(_previewMoney >= 0) {
      ownerMoney[msg.sender] -= _money;
    }
    else {
      ownerMoney[msg.sender] = 0;
    }

    return ownerMoney[msg.sender];
  }
}