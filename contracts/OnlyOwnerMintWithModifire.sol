// SPDX-License-Identifier: MIT

pragma solidity ^0.8.14;

import "@openzeppelin/contracts@4.6.0/token/ERC721/ERC721.sol";


contract OnlyOwnerMintWithModifire is ERC721 {

    /**
     * @dev
     * - kono contruct wo deproy shita address you hensuu
     */
    address public owner;

    //init
    constructor() ERC721 ("OnlyOwnerMintWithModifire", "OWNERMOD") {
        owner = _msgSender(); //toranzakusyon sousinsya no address
    }

    /**
     * @dev
     * - kono contruct wo deproy shita address omly
     */
    modifier onlyOwner {
        require(owner == _msgSender(), "Caller in not the owner.");
        _;
    }

    /**
     * @dev
     * - kono contruct wo deproy shita address nomiga jikkoukanou onlyOwner
     * - nftMint jikkoukannsuu ni tokenId wo himoduke
     */
    function nftMint(uint256 tokenId) public onlyOwner {
        _mint(_msgSender(), tokenId); 
    }
}
