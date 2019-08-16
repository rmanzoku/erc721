pragma solidity ^0.4.20;

interface IERC721TokenReceiver {
  function onERC721Received(address _operator, address _from, uint256 _tokenId, bytes _data) external returns(bytes4);
}
