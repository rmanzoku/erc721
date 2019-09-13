pragma solidity ^0.4.20;

import "./ERC721Metadata.sol";

contract MyNFT is ERC721Metadata {

  constructor (string name, string symbol) public ERC721Metadata(name, symbol) {
  }

  function mint(address _to, uint256 _tokenId) public {
    _mint(_to, _tokenId);
  }

  function exist(uint256 _tokenId) public view returns (bool){
    return _exist(_tokenId);
  }

  function updateTokenURIPrefix(string _new) public {
    _updateTokenURIPrefix(_new);
  }

  function updateIssuer(address _new) public {
    _updateIssuer(_new);
  }

}
