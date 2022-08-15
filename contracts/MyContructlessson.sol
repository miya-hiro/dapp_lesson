// SPDX-License-Identifier: MIT

pragma solidity ^0.8.14;

import "@openzeppelin/contracts@4.6.0/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.6.0/access/Ownable.sol";
import "@openzeppelin/contracts@4.6.0/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts@4.6.0/utils/Counters.sol";
import "@openzeppelin/contracts@4.6.0/utils/Strings.sol";

contract MyContructlessson is ERC721URIStorage, Ownable {

    bool public isUsed;

    /**
     * @dev
     * - URI設定時、誰が何のURIを設定したか記録する
     */
    event TokenURIChanged(address indexed sender, uint256 indexed tokenId, string uri);

    /**
     * @dev
     * - _tokenIdsはCounterdの全関数が利用可能
     */
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // /**
    //  * @dev
    //  * チケットの構造体
    //  */
    //  struct TicketInfo {
    //     string expirationDate;
    //     bool isUsed;
    // }
 
    // TicketInfo ticket_info = TicketInfo('2023-10-10', false);

    //init
    constructor() ERC721 ("MyContructlessson", "MYLESSON") {
        // expire = '今日たす３年'; //toranzakusyon sousinsya no address
    }

    // /**
    //  * @dev
    //  * - kono contruct wo deproy shita address omly
    //  */
    // modifier onlyOwner {
    //     require(owner == _msgSender(), "Caller in not the owner.");
    //     _;
    // }

    /**
     * @dev
     * - kono contruct wo deproy shita address nomiga jikkoukanou onlyOwner
     * - tokenIdをインクリメント
     * - nftMint jikkoukannsuu ni tokenId wo himoduke
     * - mintの際にURIを設定
     * - Event発火　 
     */
    function nftMint() public onlyOwner {
        _tokenIds.increment();
        uint256 newTokenId = _tokenIds.current();

        _mint(_msgSender(), newTokenId); 

        string memory jsonFile = string(abi.encodePacked('metadata', Strings.toString(newTokenId), '.json'));

        _setTokenURI(newTokenId, jsonFile);

        emit TokenURIChanged(_msgSender(), newTokenId, jsonFile);
    }

   /**
     * @dev
     * - 既存のトークンIDのURIをUsed用に変更
     */
    function setIsUsed() public onlyOwner {

        isUsed = true;    
    }

    /**
     * @dev
     * - URIプレフィックスの設定
     */
    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://bafybeiedw3zmpjp2hjwwawd4dxbdf66kysv3zf7nohpwz3y4jvtqfswxfm/";
    }

    /**
     * - オーバーライド
     */
    function tokenURI(uint256 _tokenId) public view virtual override returns (string memory) {
    
        require(_exists(_tokenId), "ERC721Metadata: URI query for nonexistent token");

        string memory baseURI = _baseURI();

    //     // Implement the features you want to add
    //     // Imagine there is already structure called TicketInfo that stores information of NFTs and "used" NFT has zero index in the collection
        uint256 tokenId = _tokenId;
        // TicketInfo storage ticket = TicketInfo;

        // emit eventDebugger('here', ticket);

        // if(ticket.expirationDate < now || ticket.isUsed) tokenId = 0;
        // if(ticket.isUsed == true) tokenId = 0;

        if(isUsed == true) {
            return string(abi.encodePacked(baseURI, "/", Strings.toString(tokenId), ".json"));
        } else {
            return string(abi.encodePacked(baseURI, "/", Strings.toString(tokenId), "-used.json"));
        }
        // return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, 'metadata', tokenId.toString()), '.json') : "";
    }
}
