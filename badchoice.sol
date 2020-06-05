pragma solidity ^0.5.11;

import "../openzeppelin-contracts/GSN/Context.sol";
import "../openzeppelin-contracts/token/ERC20/ERC20.sol";
import "../openzeppelin-contracts/token/ERC20/ERC20Detailed.sol";

import "../openzeppelin-contracts/math/SafeMath.sol";


contract BadChoiceToken is Context, ERC20, ERC20Detailed {
    uint256 tokenPrice = 100 wei;
    
    constructor () public payable ERC20Detailed("BadChoiceToken", "BCT", 18) {
        _mint(_msgSender(), SafeMath.div(msg.value, tokenPrice));
    }
    
    function buyTokens() public payable {
        _mint(_msgSender(), SafeMath.div(msg.value, tokenPrice));
    }
    
    function stringsEqual(string memory s1, string memory s2)
    public pure returns (bool) {
            return keccak256(abi.encode(s1)) == keccak256(abi.encode(s2));
    }
    
    function sellTokens(uint256 amount) public {
        // If this class is inherited by a class implementing another token,
        // the following simple check prevents undesiriable side effects.
        if(stringsEqual(symbol(), "BСT")) {
            _burn(_msgSender(), amount);
            address(msg.sender).transfer(SafeMath.mul(amount, tokenPrice));
        }
    }
}
