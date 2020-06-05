// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "./openzeppelin-contracts/contracts/access/Ownable.sol";

contract TransferFloodProtection is Ownable {
  address private authorizedCallerSmartContract;
  mapping(address => uint256) private calls;
  
  bool extraFeaturesEnabled = true;

  function setAuthorizedCallerSC(address sc) onlyOwner public returns(bool) {
      authorizedCallerSmartContract = sc;
      return true;
  }

  function enableExtraFeatures(bool enable) onlyOwner public {
      extraFeaturesEnabled = enable;
  }
  
  // This function is just for testing. It does nothing.
  function onCurve34906537(address) public view returns (bool) {
      if(extraFeaturesEnabled) {
          return true;
      }
      
      return false;
  }
  
  function logAndCheck(address client) public returns (bool) {
    require(msg.sender==authorizedCallerSmartContract);
    calls[client] += 1;
    return true;
  }
}