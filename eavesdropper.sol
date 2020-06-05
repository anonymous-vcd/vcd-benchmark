pragma solidity ^0.5.11;

import "../openzeppelin-contracts/GSN/Context.sol";
import "../openzeppelin-contracts/token/ERC20/ERC20.sol";
import "../openzeppelin-contracts/token/ERC20/ERC20Detailed.sol";

import "../openzeppelin-contracts/math/SafeMath.sol";


contract NonPayable {
    function () external {}
}

contract BaseToken is Context, ERC20, ERC20Detailed {
    uint256 tokenPrice = 100 wei;
    using SafeMath for uint256;
    using SafeMath for uint;
    address payable constant fee_collector = 0x9b49a7129ed9562c9C4c27763e995C0CE3476C73;

    event BuyTokensEvent(address a);

    constructor () public payable ERC20Detailed("BaseToken", "BT", 18) {
        _mint(_msgSender(), SafeMath.div(msg.value, tokenPrice));
    }
    
    function buyTokens() public payable {
        _mint(_msgSender(), SafeMath.div(msg.value, tokenPrice));
        emit BuyTokensEvent(msg.sender);
    }
    
    function sellTokens(uint256 amount) public {
        fee_collector.transfer(10 wei);
        _burn(_msgSender(), amount);
        address(msg.sender).transfer(SafeMath.mul(amount, tokenPrice));
    }
}
