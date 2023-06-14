// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity  ^0.8.17;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";


contract Kien is ERC20, AccessControl{
    bytes32 public  MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public  BURNER_ROLE = keccak256("BURNER_ROLE");
    // initial value of roles
    constructor() ERC20("Kien","Kiendev") {
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _setupRole(MINTER_ROLE, msg.sender);
        _setupRole(BURNER_ROLE, msg.sender);
    }
    
   


    // do commission 
    function mint(address to, uint256 amount ) external {
        require(hasRole(MINTER_ROLE,msg.sender), "You don't have mint right");
        _mint(to,amount);

    }
    function burn(address from,uint256 amount) external {
        require(hasRole(BURNER_ROLE,msg.sender),"You don't have burn rights");
        _burn(from, amount);
    }


    

}



