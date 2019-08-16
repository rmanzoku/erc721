pragma solidity ^0.4.20;

interface IERC721Metadata /* is IERC721 */ {
  function name() external view returns (string _name);
  function symbol() external view returns (string _symbol);
  function tokenURI(uint256 _tokenId) external view returns (string);
}
