// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

import "./ownerwallet.sol";

contract EstateFactory is OwnerWallet {
  event NewEstate(uint estateId, string name, uint32 level, uint32 apartaments, uint32 rentCollectionTime);

  uint estatePrice = 100000;
  uint rentCooldownTime = 1 days;

  uint32 apartamentsPerEstate = 15;

  struct Estate {
    string name;
    uint32 level;
    uint32 apartments;
    uint32 rentCollectionTime;
  }

  Estate[] public estates;

  mapping (uint => address) public estateToOwner;
  mapping (address => uint) ownerEstateCount;

  modifier hasThePurchaseValue() {
    require(ownerMoney[msg.sender] >= estatePrice);
    _;
  }

  modifier isOwnerProperty(uint _estateId) {
    require(msg.sender == estateToOwner[_estateId]);
    _;
  }

  function buyEstate(string memory _name) external hasThePurchaseValue {
    uint32 _rentCollectionTime = uint32(block.timestamp + rentCooldownTime);
    estates.push(Estate(_name, 1, apartamentsPerEstate, _rentCollectionTime));
    uint _id = estates.length - 1;    
    estateToOwner[_id] = msg.sender;
    ownerEstateCount[msg.sender]++;

    emit NewEstate(_id, _name, 1, apartamentsPerEstate, _rentCollectionTime);
  }
}