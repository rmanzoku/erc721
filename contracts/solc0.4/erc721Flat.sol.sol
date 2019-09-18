pragma solidity ^0.4.20;
// produced by the Solididy File Flattener (c) David Appleton 2018
// contact : dave@akomba.com
// released under Apache 2.0 licence
// input  /Users/rmanzoku/src/github.com/rmanzoku/erc721/contracts/solc0.4/erc721.sol
// flattened :  Wednesday, 18-Sep-19 06:57:23 UTC
interface IERC721TokenReceiver {
  function onERC721Received(address _operator, address _from, uint256 _tokenId, bytes _data) external returns(bytes4);
}

library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

library Address {

  function isContract(address account) internal view returns (bool) {
    uint256 size;
    assembly { size := extcodesize(account) }
    return size > 0;
  }

  function toAscii(address account) internal pure returns (string) {
    bytes32 value = bytes32(uint256(account));
    bytes memory alphabet = "0123456789abcdef";

    bytes memory str = new bytes(42);
    str[0] = '0';
    str[1] = 'x';
    for (uint i = 0; i < 20; i++) {
      str[2+i*2] = alphabet[uint(uint8(value[i + 12] >> 4))];
      str[3+i*2] = alphabet[uint(uint8(value[i + 12] & 0x0f))];
    }
    return string(str);
  }
}

interface IERC165 {
  function supportsInterface(bytes4 interfaceID) external view returns (bool);
}

interface IERC721 /* is IERC165 */ {
  event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);
  event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);
  event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);

  function balanceOf(address _owner) external view returns (uint256);
  function ownerOf(uint256 _tokenId) external view returns (address);
  function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes data) external payable;
  function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable;
  function transferFrom(address _from, address _to, uint256 _tokenId) external payable;
  function approve(address _approved, uint256 _tokenId) external payable;
  function setApprovalForAll(address _operator, bool _approved) external;
  function getApproved(uint256 _tokenId) external view returns (address);
  function isApprovedForAll(address _owner, address _operator) external view returns (bool);
}

contract ERC165 is IERC165 {
  bytes4 private constant _INTERFACE_ID_ERC165 = 0x01ffc9a7;

  mapping(bytes4 => bool) private _supportedInterfaces;

  constructor () internal {
    _registerInterface(_INTERFACE_ID_ERC165);
  }

  function supportsInterface(bytes4 interfaceId) external view returns (bool) {
    return _supportedInterfaces[interfaceId];
  }

  function _registerInterface(bytes4 interfaceId) internal {
    require(interfaceId != 0xffffffff, "ERC165: invalid interface id");
    _supportedInterfaces[interfaceId] = true;
  }
}

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

  function balanceOf(address _owner) public view returns (uint256) {
    return _balance[_owner];
  }

  function ownerOf(uint256 _tokenId) public view returns (address) {
    require(_exist(_tokenId),
            "`_tokenId` is not a valid NFT.");
    return _tokenOwner[_tokenId];
  }

  function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes _data) external payable {
    require(_data.length == 0, "data is not implemented");
    safeTransferFrom(_from, _to, _tokenId);
  }

  function safeTransferFrom(address _from, address _to, uint256 _tokenId) public {
    require(_checkOnERC721Received(_from, _to, _tokenId, ""),
            "`_to` is a smart contract and onERC721Received is invalid");

    transferFrom(_from, _to, _tokenId);
  }

  function transferFrom(address _from, address _to, uint256 _tokenId) public {
    require(_transferable(_from, _tokenId),
            "Unless `msg.sender` is the current owner, an authorized operator, or the approved address for this NFT.");
    require(ownerOf(_tokenId) == _from,
            "`_from` is not the current owner.");
    require(_to != address(0),
            "`_to` is the zero address.");
    require(_exist(_tokenId),
            "`_tokenId` is not a valid NFT.");

    _transfer(_from, _to, _tokenId);
  }

  function approve(address _approved, uint256 _tokenId) public {
    address owner = ownerOf(_tokenId);
    require(msg.sender == owner || isApprovedForAll(owner, msg.sender),
            "Unless `msg.sender` is the current NFT owner, or an authorized operator of the current owner.");

    _tokenApproved[_tokenId] = _approved;
    emit Approval(msg.sender, _approved, _tokenId);
  }

  function setApprovalForAll(address _operator, bool _approved) public {
    _operatorApprovals[msg.sender][_operator] = _approved;
    emit ApprovalForAll(msg.sender, _operator, _approved);
  }

  function getApproved(uint256 _tokenId) public view returns (address) {
    require(_exist(_tokenId),
            "`_tokenId` is not a valid NFT.");
    return _tokenApproved[_tokenId];
  }

  function isApprovedForAll(address _owner, address _operator) public view returns (bool) {
    return _operatorApprovals[_owner][_operator];
  }

  function _transferable(address _spender, uint256 _tokenId) internal view returns (bool){
    address owner = ownerOf(_tokenId);
    return (_spender == owner || getApproved(_tokenId) == _spender || isApprovedForAll(owner, _spender));
  }

  function _transfer(address _from, address _to, uint256 _tokenId) internal {
    _clearApproval(_tokenId);
    _tokenOwner[_tokenId] = _to;
    _balance[_from] = _balance[_from].sub(1);
    _balance[_to] = _balance[_to].add(1);
    emit Transfer(_from, _to, _tokenId);
  }
  
  function _mint(address _to, uint256 _tokenId) internal {
    require(!_exist(_tokenId), "mint token already exists");
    _tokenOwner[_tokenId] = _to;
    _balance[_to] = _balance[_to].add(1);
    emit Transfer(address(0), _to, _tokenId);
  }
  
  function _burn(uint256 _tokenId) internal {
    require(_exist(_tokenId), "burn token does not already exists");
    address owner = ownerOf(_tokenId);
    _tokenOwner[_tokenId] = address(0);
    _balance[owner] = _balance[owner].sub(1);
    emit Transfer(owner, address(0), _tokenId);
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

