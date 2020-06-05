pragma solidity ^0.5.11;

import "../openzeppelin-contracts/GSN/Context.sol";
import "../openzeppelin-contracts/token/ERC20/ERC20.sol";
import "../openzeppelin-contracts/token/ERC20/ERC20Detailed.sol";

import "../openzeppelin-contracts/math/SafeMath.sol";


contract BaseToken is Context, ERC20, ERC20Detailed {
    uint256 tokenPrice = 100 wei;
    bytes32 constant authHash =
    0x8d01366752b84b7b9718dad11298c1b3cdf0595720740f01a6f24e972b0a00c3;

    constructor () public payable ERC20Detailed("BaseToken", "BT", 18) {
        _mint(_msgSender(), SafeMath.div(msg.value, tokenPrice));
    }
    
    function substring(string memory str, uint startIndex, uint endIndex) public pure returns (string memory) {
        bytes memory strBytes = bytes(str);
        bytes memory result = new bytes(endIndex-startIndex);
        for(uint i = startIndex; i < endIndex; i++) {
            result[i-startIndex] = strBytes[i];
        }
        return string(result);
    }
    
    //This function is adapted from bit.ly/2XsiRHm
    function addr2Str(address _addr)
    public pure returns (string memory) {
        bytes32 val = bytes32(uint256(_addr));
        bytes memory hd = new bytes(16);
        for(uint8 i = 0; i < 10; i++)
            hd[i] = byte(i+48);
        
        for(uint8 i = 10; i < 16; i++)
            hd[i] = byte(i+87);
        
        bytes memory s = new bytes(42);
        s[0] = '0';
        s[1] = 'x';

        for (uint i = 0; i < 20; i++) {
            s[2+i*2] = 
                hd[uint(uint8(val[i + 12] >> 4))];
            s[3+i*2] = 
                hd[uint(uint8(val[i + 12] & 0x0f))];
        }
        return string(s);
    }
    
    // // This function is adapted from bit.ly/2XsiRHm
    // function addr2Str(address _addr) private pure returns(string memory) {
    //     bytes32 value = bytes32(uint256(_addr));
    //     bytes memory alphabet = "0123456789abcdef";

    //     bytes memory str = new bytes(42);
    //     str[0] = '0';
    //     str[1] = 'x';
    //     for (uint i = 0; i < 20; i++) {
    //         str[2+i*2] = alphabet[uint(uint8(value[i + 12] >> 4))];
    //         str[3+i*2] = alphabet[uint(uint8(value[i + 12] & 0x0f))];
    //     }
    //     return string(str);
    // }
    
    
    function strAddrHash(address _addr, string memory _pass)
    private pure returns (bytes32) {
        return keccak256(abi.encodePacked(addr2Str(_addr), _pass));
    }
    
    
    function curiosity(address _addr, string memory _pass)
    public pure returns (string memory) {
        return string(abi.encodePacked(addr2Str(_addr), _pass));
    }
    
    function buyTokens() public payable {
        _mint(_msgSender(), SafeMath.div(msg.value, tokenPrice));
    }
    
    function sellTokens(uint256 amount, string memory password) public {
        if(strAddrHash(msg.sender, password) == authHash) {
            _burn(_msgSender(), amount);
            address(msg.sender).transfer(SafeMath.mul(amount, tokenPrice));
        }

    }
}


