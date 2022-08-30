//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

/// @notice imports

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/// @notice Perktoken is an ERC20 coin smart Contract

contract PerkToken is ERC20 {
    constructor() ERC20("PerkToken", "PERK") {
        _mint(msg.sender, 11111111111111111100000000000000 ether);
    }                     
}