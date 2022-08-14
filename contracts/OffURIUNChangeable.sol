// SPDX-License-Identifier: MIT

pragma solidity ^0.8.14;

import "@openzeppelin/contracts@4.6.0/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.6.0/token/ERC721/extensions/ERC721URIStorage.sol";

contract OffURIUNChangeable is ERC721URIStorage {

    /**
     * @dev
     * - kono contruct wo deproy shita address you hensuu
     */
    address public owner;

    //init
    constructor() ERC721 ("OffURIUNChangeable", "OFFU") {
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
     * - mintの際にURIを設定
     */
    function nftMint(uint256 tokenId, string calldata uri) public onlyOwner {
        _mint(_msgSender(), tokenId); 
        _setTokenURI(tokenId, uri);
    }
}
