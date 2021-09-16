// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

import "./estatehelper.sol";

contract EstateRent is EstateHelper {
  uint32 rentPerLevel = 150;

  function getOwnerPendingRentals() external view {
    // ...
  }

  function _calculeRent(uint32 _level, uint32 _apartaments) internal view returns (uint) {
    uint32 rentPerApartament = _level * rentPerLevel;

    return _apartaments * rentPerApartament;
  }

  function chargeRent(uint _estateId) external isOwnerProperty(_estateId) returns (uint) {
    Estate storage estate = estates[_estateId];

    require(block.timestamp <= estate.rentCollectionTime);

    uint totalRent = _calculeRent(estate.level, estate.apartments);
    
    _ownerAddMoney(totalRent);

    estate.rentCollectionTime = uint32(block.timestamp + rentCooldownTime);

    return ownerMoney[msg.sender];
  }
}