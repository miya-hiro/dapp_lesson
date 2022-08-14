// SPDX-License-Identifier: MIT

pragma solidity ^0.8.14;

import "@openzeppelin/contracts@4.6.0/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.6.0/token/ERC721/extensions/ERC721URIStorage.sol";

contract OffURIChangeable is ERC721URIStorage {

    /**
     * @dev
     * - kono contruct wo deproy shita address you hensuu
     */
    address public owner;

    //init
    constructor() ERC721 ("OffURIChangeable", "OFFC") {
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

    /**
     * @dev
     * - 既存のトークンIDにURIを紐付け
     */
    function setTokenURI(uint256 tokenId, string calldata uri) public onlyOwner {
        _setTokenURI(tokenId, uri);
    }
}
