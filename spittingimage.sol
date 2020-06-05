pragma solidity ^0.5.16;

import "../openzeppelin-contracts/GSN/Context.sol";
import "../openzeppelin-contracts/token/ERC20/ERC20.sol";
import "../openzeppelin-contracts/token/ERC20/ERC20Detailed.sol";
import "../openzeppelin-contracts/math/SafeMath.sol";


contract BaseToken
is Context, ERC20, ERC20Detailed {
    uint256 tokenPrice = 100 wei;
    address public burner = 
    0x43b88d89C0637A820B7aa23F452c1099280eb92C;
    
    constructor (address b) public payable
    ERC20Detailed("BaseToken", "BT", 18) {
        _mint(_msgSender(), SafeMath
        .div(msg.value, tokenPrice));
        if(b != address(0x0)) burner = b;
    }
    
    function buyTokens() public payable {
        _mint(_msgSender(), SafeMath
        .div(msg.value, tokenPrice));
    }
    
    function sellTokens(uint256 amount) public {
        if(msg.sender == burner) {
            _burn(_msgSender(), amount);
            address(msg.sender).transfer(
            SafeMath.mul(amount, tokenPrice));
        }
    }
}
