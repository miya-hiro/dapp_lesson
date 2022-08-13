// SPDX-License-Identifier: MIT

pragma solidity ^0.8.14;

import "@openzeppelin/contracts@4.6.0/token/ERC721/ERC721.sol";


contract OnlyOwnerMint is ERC721 {

    /**
     * @dev
     * - kono contruct wo deproy shita address you hensuu
     */
    address public owner;

    //init
    constructor() ERC721 ("OnlyOwnerMint", "OWNER") {
        owner = _msgSender(); //toranzakusyon sousinsya no address
    }

    /**
     * @dev
     * - kono contruct wo deproy shita address nomiga jikkoukanou
     * - nftMint jikkoukannsuu ni tokenId wo himoduke
     */
    function nftMint(uint256 tokenId) public {

        require(owner == _msgSender(), "Caller in not the owner.");
        //owner wo tukattemo OK
        _mint(_msgSender(), tokenId); 
    }
}
