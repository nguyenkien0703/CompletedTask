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
    
    // view role'bytes32
    function getMinterRole() public view  returns (bytes32) {
       // return keccak256("MINTER_ROLE");
       return MINTER_ROLE;
    }

    function getBurnerRole() public view  returns (bytes32) {
        // return keccak256("MINTER_ROLE");
        return BURNER_ROLE; 
    }



    // do commission 
    function mint(address to, uint256 amount ) public {
        require(hasRole(MINTER_ROLE,msg.sender), "You don't have mint right");
        _mint(to,amount);

    }
    function burn(address from,uint256 amount) public {
        require(hasRole(BURNER_ROLE,msg.sender),"You don't have burn rights");
        _burn(from, amount);
    }


    // granted for a account 
    function grantedMinterRole(address account ) public {
        grantRole(MINTER_ROLE, account);
    }
    function grantedBurnRole(address account) public {
        grantRole(BURNER_ROLE, account);
    }
    // check account'role 
    function hasMinterRole(address account ) public  view returns (bool) {
        return  hasRole(MINTER_ROLE, account);
    }
    function hasBurnRole(address account ) public view returns (bool ){
        return hasRole(BURNER_ROLE, account);
    }

}



