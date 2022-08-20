// SPDX-License-Identifier: MIT

pragma solidity ^0.8.14;

import "@openzeppelin/contracts@4.6.0/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.6.0/access/Ownable.sol";
import "@openzeppelin/contracts@4.6.0/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts@4.6.0/utils/Counters.sol";
import "@openzeppelin/contracts@4.6.0/utils/Strings.sol";

contract MyContructlessson is ERC721URIStorage, Ownable {

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

    /**
     * @dev
     * チケットの構造体
     */
     struct TicketInfo {
        uint id256;
        uint expirationDate;
        bool isUsed;
    }
 
    TicketInfo[] public ticketInfos;

    //init
    constructor() ERC721 ("MyContructlessson", "MYLESSON") {
        TicketInfo memory zeroTicketInfo = TicketInfo(0,  block.timestamp, false);
        ticketInfos.push(zeroTicketInfo);
    }

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

        TicketInfo memory newTicketInfo = TicketInfo(newTokenId,  block.timestamp + 1 hours, false);
        ticketInfos.push(newTicketInfo);

        emit TokenURIChanged(_msgSender(), newTokenId, jsonFile);
    }

   /**
     * @dev
     * - 既存のトークンIDのURIをUsed用に変更
     */
    function setIsUsed(uint256 _tokenId) public onlyOwner {
        uint256 tokenId = _tokenId;
        TicketInfo storage ticket = ticketInfos[tokenId];
        ticket.isUsed = true;    
    }

    /**
     * @dev
     * - URIプレフィックスの設定
     */
    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://bafybeicsy2u367vafyfps5uiilhc6vxnmwxglw2yycbxcxolinupowrtbu/";
    }

    /**
     * - tokenUriを返すメソッドをオーバーライド
     */
    function tokenURI(uint256 _tokenId) public view virtual override returns (string memory) {
    
        require(_exists(_tokenId), "ERC721Metadata: URI query for nonexistent token");

        string memory baseURI = _baseURI();

        // Implement the features you want to add
        // Imagine there is already structure called TicketInfo that stores information of NFTs and "used" NFT has zero index in the collection
        uint256 tokenId = _tokenId;
        TicketInfo storage ticket = ticketInfos[tokenId];

        if(ticket.isUsed == true || ticket.expirationDate < block.timestamp) {
            return  string(abi.encodePacked(baseURI, 'metadata', Strings.toString(tokenId), '-used.json'));
        } else {
            return  string(abi.encodePacked(baseURI, 'metadata', Strings.toString(tokenId), '.json'));
        }
    }
}
