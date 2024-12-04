// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

import {ERC20} from "@openzeppelin/contracts@5.1.0/token/ERC20/ERC20.sol";
import {ERC20Permit} from "@openzeppelin/contracts@5.1.0/token/ERC20/extensions/ERC20Permit.sol";

contract BlackSwan is ERC20, ERC20Permit {
    constructor() ERC20("BlackSwan", "BSW") ERC20Permit("BlackSwan") {
        _mint(msg.sender, 1000 * 10 ** decimals());
    }
}
