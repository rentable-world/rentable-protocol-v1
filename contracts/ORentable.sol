// SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.11;

import "./ERC721ReadOnlyProxy.sol";
import "./Rentable.sol";

contract ORentable is ERC721ReadOnlyProxy {
    address internal _rentable;

    string constant PREFIX = "o";

    constructor(address wrapped_)
        ERC721ReadOnlyProxy(wrapped_, PREFIX)
    {}

    function init(address wrapped, address owner) external virtual {
        _init(wrapped, PREFIX, owner);
    }

    function setRentable(address rentable_)
        external
        onlyOwner
    {
        _rentable = rentable_;
        _minter = rentable_;
    }
    

    function _transfer(address from, address to, uint256 tokenId) override internal virtual {
        super._transfer(from, to, tokenId);
        Rentable(_rentable).afterOTokenTransfer(_wrapped, from, to, tokenId);
    }
}