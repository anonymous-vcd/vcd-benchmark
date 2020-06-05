// SPDX-License-Identifier: WT*PL

pragma solidity ^0.6.0;

contract NonPayableContract {
    function hello() public pure returns(string memory) {
        return "hello";
    }
}