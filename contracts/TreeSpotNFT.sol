// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import '@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol';

contract TreeSpotNFT is ERC721Enumerable {
    
    struct TokenAttr {
        uint256 width;
        string letter;
        string tokenURI;
    }
    mapping (uint256 => TokenAttr) _tokenAttributes;    

    constructor() ERC721("TreeSpotNFT", "TSN") {

    }

    function mint(string memory text) public {
        uint256 tokenId = ERC721Enumerable.totalSupply();
        _safeMint(msg.sender, tokenId, '');
        _tokenAttributes[tokenId] = TokenAttr(bytes(text).length, text, "");
    }

    function changeLetter(uint256 tokenId, string memory newLetter) public {
        require (msg.sender == ERC721.ownerOf(tokenId));

        TokenAttr storage tokenAttr = _tokenAttributes[tokenId];
        
        require(tokenAttr.width >= bytes(newLetter).length);
        tokenAttr.letter = newLetter;
    }

    /**
     * @dev See {IERC721Metadata-tokenURI}.
     */
    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "ERC721URIStorage: URI query for nonexistent token");

        string memory _tokenURI = _tokenAttributes[tokenId].tokenURI;
        string memory base = _baseURI();

        // If there is no base URI, return the token URI.
        if (bytes(base).length == 0) {
            return _tokenURI;
        }
        // If both are set, concatenate the baseURI and tokenURI (via abi.encodePacked).
        if (bytes(_tokenURI).length > 0) {
            return string(abi.encodePacked(base, _tokenURI));
        }

        return super.tokenURI(tokenId);
    }

    /**
     * @dev Sets `_tokenURI` as the tokenURI of `tokenId`.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function _setTokenURI(uint256 tokenId, string memory _tokenURI) internal virtual {
        require(_exists(tokenId), "ERC721URIStorage: URI set of nonexistent token");
        require(msg.sender == ERC721.ownerOf(tokenId));
        TokenAttr storage tokenAttr = _tokenAttributes[tokenId];
        tokenAttr.tokenURI = _tokenURI;
    }

}