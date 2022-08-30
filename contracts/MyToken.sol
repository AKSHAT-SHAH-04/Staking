//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;
/// @notice imports

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/// @notice Mytoken is an ERC20 stable coin smart Contract

contract MyToken is ERC20 {
    constructor() ERC20("MyToken", "MTC") {
        _mint(msg.sender, 11111111111111111100000000000000 ether);
    }                    
}