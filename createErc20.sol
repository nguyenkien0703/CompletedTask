// SPDX-License-Identifier: MIT
pragma solidity  ^0.8.17;
contract createErc20  {
    string public name ;
    string public symbol ;
    uint8 public decimals;
    uint256 public totalSupply;
    bool public isPaused;
    address public admin ;

    mapping (address => uint) public balances;
    mapping (address => bool) public minters;
    mapping (address => bool) public burners    ;
    //events 
    event Transfer(address indexed from, address indexed to, uint value );
    event Approval(address indexed owner, address indexed spender, uint value );
    event Paused();
    event UnPaused();

    // modifier check role 
    modifier isAdmin(){
        require(msg.sender == admin, "only admin can call this function");
        _;
    }
    modifier isMinter(){
        require(minters[msg.sender],"only minter can call this function");
        _;
    }
    modifier isBurner(){
        require(burners[msg.sender], "only burner can call this function");
        _;
    }

    //Initialize  supplier  token start at 0 token 
    constructor (){
        name = "Kien_dev";
        symbol ="intern";
        decimals= 18;
        totalSupply =0;
        admin = msg.sender ;
        isPaused = false ;
    }
   
    // token are mintable 
    function _mint (address account, uint value) public isMinter returns (bool) {
        require(account != address(0), "invalid account address");
        require(totalSupply + value <= 1_000_000_000 * 10 **uint256(decimals),"minting can exceed regulation ");
        totalSupply += value;
        balances[account ] += value;
        emit Transfer(address(0), account, value);
        return true;
    }

    //token are burnable 
    function _burn (uint value ) public isBurner returns (bool) {
        require(value <= balances[msg.sender], "insufficient balance for burning " );
        totalSupply -= value;
        balances[msg.sender ] -= value;
        emit Transfer(msg.sender, address(0), value);
        return true;
    }


    function pause() public isAdmin {
        isPaused = true ;
        emit Paused();
    }
    function unpause() public isAdmin{
        isPaused = false;
        emit UnPaused();
    }






}




