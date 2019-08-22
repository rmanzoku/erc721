pragma solidity ^0.5.0;

interface ERC721Mintable {
  function mint(address to, uint256 tokenId) external returns (bool);
  function isMinter(address account) external view returns (bool);
  function renounceMinter() external;
}

contract ERC721BultMinter {

  ERC721Mintable Alice;
  address operator;

  modifier onlyOperator() {
    require(msg.sender == operator);
    _;
  }

  constructor() public {
    operator = msg.sender;
  }

  function renounce() public onlyOperator() {
    Alice.renounceMinter();
  }

  function set(address _new) external onlyOperator() {
    Alice = ERC721Mintable(_new);
    require(Alice.isMinter(address(this)), "address(this) is must be minter");
  }

  function mint(uint256[] calldata _tokenIds, address[] calldata _owners) external onlyOperator() {
    require(_tokenIds.length == _owners.length);
    for (uint256 i = 0; i < _tokenIds.length; i++) {
      Alice.mint(_owners[i], _tokenIds[i]);
    }
  }

}
