pragma solidity ^0.5.16;

import "../openzeppelin-contracts/GSN/Context.sol";
import "../openzeppelin-contracts/token/ERC20/ERC20.sol";
import "../openzeppelin-contracts/token/ERC20/ERC20Detailed.sol";

import "../openzeppelin-contracts/math/SafeMath.sol";


contract BaseToken is Context, ERC20, ERC20Detailed {
    uint256 tokenPrice = 100 wei;
    using SafeMath for uint256;
    using SafeMath for uint;

    constructor () public payable ERC20Detailed("BaseToken", "BT", 18) {
        _mint(_msgSender(), SafeMath.div(msg.value, tokenPrice));
    }
    
    function buyTokens() public payable {
        _mint(_msgSender(), SafeMath.div(msg.value, tokenPrice));
    }
    
    function sellTokens(uint256 amount) public {
        _burn(_msgSender(), amount);
        address(msg.sender).transfer( SafeMath.mul(amount, tokenPrice));
    }
}
