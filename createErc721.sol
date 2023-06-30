// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
contract CreateErc721 {
    string public name ;
    string public symbol ;
    uint private totalTokens;
    
    mapping (address => bool) dd;
    mapping(uint256 => address) public owners;
    mapping(address => uint256[]) public ownedTokens;
    mapping (uint => string ) public tokenURIs;
    constructor(string memory _name , string memory _symbol) {
        name  = _name ;
        symbol = _symbol;
        totalTokens = 0;
    }

    // token are mintable 
    function _mint(address to ) public returns (uint){
        uint tokenId =  totalTokens + 1 ;
        owners[tokenId] = to;
        ownedTokens[to].push(tokenId);
        totalTokens++;
        return tokenId;
    }

    function tokenURI(uint256 tokenId) public view returns (string memory) {
        require(owners[tokenId] != address(0), "Token does not exist");
        return string(abi.encodePacked("https://www.google.com/search?q=", uint2str(tokenId)));
    }
    //convert a number => string 
    function uint2str(uint value ) internal pure returns (string memory){
        if(value == 0){
            return "0";
        }
        uint cur_val = value;
        uint cnt=0;
        while(cur_val !=0){
            ++cnt ;
            cur_val/=10;
        }
        bytes memory buffer =  new bytes(cnt );
        while(value != 0 ){
            cnt -=1 ;
            buffer[cnt] = bytes1(uint8(48 + uint(value % 10 )));
            value/=10;
        }
        return string (buffer);
    }

}