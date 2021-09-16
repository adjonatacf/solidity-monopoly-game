// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

import "./estatefactory.sol";

contract EstateHelper is EstateFactory {
  function getEstatesByOwner(address _owner) internal view returns(uint[] memory) {
    uint[] memory result = new uint[](ownerEstateCount[_owner]);

    uint counter = 0;
    for (uint i = 0; i < estates.length; i++) {
      if (estateToOwner[i] == _owner) {
        result[counter] = i;
        counter++;
      }
    }

    return result;
  }
}