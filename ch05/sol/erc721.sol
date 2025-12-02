// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

interface ERC165 {
    function supportsInterface(bytes4 interfaceID) external view returns(bool);
}

interface ERC721 /* is ERC165 */ {
  event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);
  event Approval(address indexed _from, address indexed _approved, uint256 indexed _tokenId);
  event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);
  function balanceOf(address _owner) external view returns (uint256);
  function ownerOf(uint256 _tokenId) external view returns (address);
  function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes memory data) external payable;
  function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable;
  function transferFrom(address _from, address _to, uint256 _tokenId) external payable;
  function approve(address _approved, uint256 _tokenId) external payable;
  function setApprovalForAll(address _operator, bool _approved) external;
  function getApproved(uint256 _tokenId) external view returns (address);
  function isApprovedForAll(address _owner, address _operator) external view returns (bool);
}

interface ERC721TokenReceiver {
    function onERC721Received(address _operator, address _from, uint256 _tokenId, bytes memory _data) external returns(bytes4);
}

contract ERC721Impl is ERC165, ERC721 {
    mapping(bytes4 => bool) supportsInterfaces;
    bytes4 invalidID = 0xffffffff;
    bytes4 constant ERC165_InterfaceID = 0x01ffc9a7; // ERC165标准接口ID
    bytes4 constant ERC721_InterfaceID = 0x80ac58cd; // ERC721标准接口ID
    mapping(address => uint256) ercTokenCount; // 用户持有 NFT 的数量
    mapping(uint256 => address) ercTokenOwner; // NFT对应的属主
    mapping(uint256 => address) ercTokenApproved; // 属主仅将某个NFT授权给某个操作者
    mapping(address => mapping(address=>bool)) ercOperatorForAll; // 属主将所有信息(包括所有NFT以及授权的能力)都授权给某个操作者

    constructor() {
        _registerInterface(ERC165_InterfaceID);
        _registerInterface(ERC721_InterfaceID);
    }
    
    function _registerInterface(bytes4 interfaceID) internal {
        supportsInterfaces[interfaceID] = true;
    }

    function supportsInterface(bytes4 interfaceID) override external view returns (bool) {
        require(invalidID != interfaceID, "invalid interfaceID");
        return supportsInterfaces[interfaceID];
    }

    function balanceOf(address _owner) override external view returns (uint256) {
        return ercTokenCount[_owner];
    }

    function ownerOf(uint256 _tokenId) override external view returns (address) {
        return ercTokenOwner[_tokenId];
    }

    function getApproved(uint256 _tokenId) override external view returns (address) {
        return ercTokenApproved[_tokenId];
    }

    function isApprovedForAll(address _owner, address _operator) override external view returns (bool) {
        return ercOperatorForAll[_owner][_operator];
    }

    modifier canOperator(uint256 _tokenId) {
        address owner = ercTokenOwner[_tokenId];
        require(msg.sender == owner || ercOperatorForAll[owner][msg.sender]);
        _;
    }

    modifier canTransfer(uint256 _tokenId, address _from) {
        address owner = ercTokenOwner[_tokenId];
        require(owner == _from, "token's owner is not _from");
        require(msg.sender == owner || ercTokenApproved[_tokenId] == msg.sender || ercOperatorForAll[owner][msg.sender]);
        _;
    }

    function approve(address _approved, uint256 _tokenId) override canOperator(_tokenId) external payable {
        ercTokenApproved[_tokenId] = _approved;
        emit Approval(msg.sender, _approved, _tokenId);
    }

    function setApprovalForAll(address _operator, bool _approved) override external {
        ercOperatorForAll[msg.sender][_operator] = _approved;
        emit ApprovalForAll(msg.sender, _operator, _approved);
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) override external payable {
        _transferFrom(_from, _to, _tokenId);
    }

    function _transferFrom(address _from, address _to, uint256 _tokenId) internal canTransfer(_tokenId, _from) {
        ercTokenOwner[_tokenId] = _to;  // 更改属主
        ercTokenCount[_from] -= 1;
        ercTokenCount[_to] += 1;
        // 取消授权
        ercTokenApproved[_tokenId] = address(0);

        emit Transfer(_from, _to, _tokenId);
    }

    function _safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes memory data) internal {
        _transferFrom(_from, _to, _tokenId);
    
        if (_to.code.length > 0) {
            bytes4 retval = ERC721TokenReceiver(_to).onERC721Received(msg.sender, _from, _tokenId, data);
            require(retval == ERC721TokenReceiver.onERC721Received.selector, "retval not equal onERC721Received's interfaceID");
        }
    }

    function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes memory data) override external payable {
        _safeTransferFrom(_from, _to, _tokenId, data);       
    }

    function safeTransferFrom(address _from, address _to, uint256 _tokenId) override external payable {
        _safeTransferFrom(_from, _to, _tokenId, "");
    }

    function mint(address _to, uint256 _tokenId, string memory data) external payable {
        require(_to != address(0), "_to is a zero address");
        require(ercTokenOwner[_tokenId] == address(0), "_tokenId already exists");

        ercTokenOwner[_tokenId] = _to;
        ercTokenCount[_to] += 1;

        if (_to.code.length > 0) {
            bytes4 retval = ERC721TokenReceiver(_to).onERC721Received(msg.sender, address(0), _tokenId, bytes(data));
            require(retval == ERC721TokenReceiver.onERC721Received.selector, "retval not equal onERC721Received's interfaceID");
        }

        emit Transfer(address(0), _to, _tokenId);
    }
}