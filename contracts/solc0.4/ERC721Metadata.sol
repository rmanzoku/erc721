pragma solidity ^0.4.20;

import "./ERC721.sol";
import "./IERC721Metadata.sol";
import "./SafeMath.sol";
import "./Address.sol";

contract ERC721Metadata is ERC721, IERC721Metadata {

  using SafeMath for uint256;
  using Address for address;

  bytes4 private constant _InterfaceId_ERC721Metadata = 0x5b5e139f;

  string private _name;
  string private _symbol;

  string private _tokenURIPrefix = "https://beta-api.mch.plus/metadata/ethereum/rinkeby/";
  string private query = "?iss=";
  string private slash = "/";
  address private _issuer;

  constructor (string name, string symbol) public {
    _registerInterface(_InterfaceId_ERC721Metadata);
    _name = name;
    _symbol = symbol;
    _issuer = msg.sender;
  }

  function name() external view returns (string) {return _name;}

  function symbol() external view returns (string) {return _symbol;}

  function tokenURI(uint256 _tokenId) external view returns (string) {
    bytes32 tokenIdBytes32;

    uint256 idLen = 0;
    if (_tokenId == 0) {
      tokenIdBytes32 = "0";
    } else {
      uint256 value = _tokenId;
      while (value > 0) {
        tokenIdBytes32 = bytes32(uint256(tokenIdBytes32) / (2 ** 8));
        tokenIdBytes32 |= bytes32(((value % 10) + 48) * 2 ** (8 * 31));
        value /= 10;
        idLen++;
      }
    }

    bytes memory prefixBytes = bytes(_tokenURIPrefix);
    bytes memory thisAddressBytes = bytes(address(this).toAscii());
    bytes memory slashBytes = bytes(slash);
    bytes memory queryBytes = bytes(query);
    bytes memory issuerAddressBytes = bytes(_issuer.toAscii());

    bytes memory tokenURIBytes = new bytes(prefixBytes.length
                                           + thisAddressBytes.length
                                           + slashBytes.length
                                           + idLen
                                           + queryBytes.length
                                           + issuerAddressBytes.length);

    uint8 i;
    uint8 index = 0;

    for (i = 0; i < prefixBytes.length; i++) {
      tokenURIBytes[index] = prefixBytes[i];
      index++;
    }

    for (i = 0; i < thisAddressBytes.length; i++) {
      tokenURIBytes[index] = thisAddressBytes[i];
      index++;
    }

    for (i = 0; i < slashBytes.length; i++) {
      tokenURIBytes[index] = slashBytes[i];
      index++;
    }

    for (i = 0; i < idLen; i++) {
      tokenURIBytes[index] = tokenIdBytes32[i];
      index++;
    }

    for (i = 0; i < queryBytes.length; i++) {
      tokenURIBytes[index] = queryBytes[i];
      index++;
    }

    for (i = 0; i < issuerAddressBytes.length; i++) {
      tokenURIBytes[index] = issuerAddressBytes[i];
      index++;
    }

    return string(tokenURIBytes);
  }

  function _updateTokenURIPrefix(string _new) internal {
    _tokenURIPrefix = _new;
  }

  function _updateIssuer(address _new) internal {
    _issuer = _new;
  }
}
