// SPDX-License-Identifier: MIT

pragma solidity ^0.8.14;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MyNft is ERC721 {

    //init
    constructor() ERC721 ("MyNft", "MYNFT") {}

    function nftMint() public {
        
    }
}

