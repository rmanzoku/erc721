pragma solidity ^0.4.20;

import "./ERC165.sol";
import "./IERC721.sol";
import "./IERC721TokenReceiver.sol";
import "./SafeMath.sol";
import "./Address.sol";

contract ERC721 is ERC165, IERC721 {

  using SafeMath for uint256;
  using Address for address;

  bytes4 private constant _ERC721_RECEIVED = 0x150b7a02;
  bytes4 private constant _InterfaceId_ERC721 = 0x80ac58cd;

  mapping (uint256 => address) private _tokenOwner;
  mapping (address => uint256) private _balance;
  mapping (uint256 => address) private _tokenApproved;
  mapping (address => mapping (address => bool)) private _operatorApprovals;

  // ERC165
  constructor () public {
    _registerInterface(_InterfaceId_ERC721);
  }

  // ERC721 must be implement balanceOf(address)
  function balanceOf(address _owner) external view returns (uint256) {
    return _balanceOf(_owner);
  }

  // ERC721 must be implement ownerOf(uint256)
  function ownerOf(uint256 _tokenId) external view returns (address) {
    return _ownerOf(_tokenId);
  }

  function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes data) external payable {
    require(data.length == 0, "data is not implemented");
    require(msg.value == 0, "payable is not implemented");
    _safeTransferFrom(_from, _to, _tokenId);
  }

  function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable {
    require(msg.value == 0, "payable is not implemented");
    _safeTransferFrom(_from, _to, _tokenId);
  }

  function transferFrom(address _from, address _to, uint256 _tokenId) external payable {
    require(msg.value == 0, "payable is not implemented");
    _transferFrom(_from, _to, _tokenId);
  }

  function approve(address _approved, uint256 _tokenId) external payable {
    require(msg.value == 0, "payable is not implemented");
    _approve(_approved, _tokenId);
  }

  function setApprovalForAll(address _operator, bool _approved) external {
    _setApprovalForAll(_operator, _approved);
  }

  function getApproved(uint256 _tokenId) external view returns (address) {
    return _getApproved(_tokenId);
  }

  function isApprovedForAll(address _owner, address _operator) external view returns (bool) {
    return _isApprovedForAll(_owner, _operator);
  }

  function _balanceOf(address _owner) internal view returns (uint256) {
    return _balance[_owner];
  }

  function _ownerOf(uint256 _tokenId) internal view returns (address) {
    require(_exist(_tokenId),
            "`_tokenId` is not a valid NFT.");
    return _tokenOwner[_tokenId];
  }

  function _safeTransferFrom(address _from, address _to, uint256 _tokenId) internal {
    require(_checkOnERC721Received(_from, _to, _tokenId, ""),
            "`_to` is a smart contract and onERC721Received is invalid");

    _transferFrom(_from, _to, _tokenId);
  }

  function _transferFrom(address _from, address _to, uint256 _tokenId) internal {
    require(_transferable(_from, _tokenId),
            "Unless `msg.sender` is the current owner, an authorized operator, or the approved address for this NFT.");
    require(_ownerOf(_tokenId) == _from,
            "`_from` is not the current owner.");
    require(_to != address(0),
            "`_to` is the zero address.");
    require(_exist(_tokenId),
            "`_tokenId` is not a valid NFT.");

    _transfer(_from, _to, _tokenId);
  }

  function _approve(address _approved, uint256 _tokenId) internal {
    address owner = _ownerOf(_tokenId);
    require(msg.sender == owner || _isApprovedForAll(owner, msg.sender),
            "Unless `msg.sender` is the current NFT owner, or an authorized operator of the current owner.");

    _tokenApproved[_tokenId] = _approved;
    emit Approval(msg.sender, _approved, _tokenId);
  }

  function _setApprovalForAll(address _operator, bool _approved) internal {
    _operatorApprovals[msg.sender][_operator] = _approved;
    emit ApprovalForAll(msg.sender, _operator, _approved);
  }

  function _getApproved(uint256 _tokenId) internal view returns (address) {
    require(_exist(_tokenId),
            "`_tokenId` is not a valid NFT.");
    return _tokenApproved[_tokenId];
  }

  function _isApprovedForAll(address _owner, address _operator) internal view returns (bool) {
    return _operatorApprovals[_owner][_operator];
  }

  function _transferable(address _spender, uint256 _tokenId) internal view returns (bool){
    address owner = _ownerOf(_tokenId);
    return (_spender == owner || _getApproved(_tokenId) == _spender || _isApprovedForAll(owner, _spender));
  }

  function _transfer(address _from, address _to, uint256 _tokenId) internal {
    _clearApproval(_tokenId);
    _tokenOwner[_tokenId] = _to;
    _balance[_from] = _balance[_from].sub(1);
    _balance[_to] = _balance[_to].add(1);
    emit Transfer(_from, _to, _tokenId);
  }

  function _exist(uint256 _tokenId) internal view returns (bool) {
    address owner = _tokenOwner[_tokenId];
    return owner != address(0);
  }

  function _checkOnERC721Received(address _from, address _to, uint256 _tokenId, bytes memory _data) internal returns (bool) {
    if (!_to.isContract()) {
      return true;
    }
    bytes4 retval = IERC721TokenReceiver(_to).onERC721Received(msg.sender, _from, _tokenId, _data);
    return (retval == _ERC721_RECEIVED);
  }

  function _clearApproval(uint256 tokenId) private {
    if (_tokenApproved[tokenId] != address(0)) {
      _tokenApproved[tokenId] = address(0);
    }
  }
}
