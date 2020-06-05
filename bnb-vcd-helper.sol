// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "./openzeppelin-contracts/contracts/access/Ownable.sol";

contract ConsolidatedDatabase is Ownable {
  address private authorizedCallerSmartContract;
  mapping(address => uint256) private clientVolumes;
  
  function setAuthorizedCallerSC(address sc) onlyOwner public {
      authorizedCallerSmartContract = sc;
  }
  
  function logVolume(address client, uint256 amount) public {
    require(msg.sender==authorizedCallerSmartContract);
    clientVolumes[client] += amount;
  }
}