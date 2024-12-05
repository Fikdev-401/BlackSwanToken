// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Burnable} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {ERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract BlackSwan is ERC20, ERC20Burnable, Ownable, ERC20Permit {
    uint256 public constant MAX_SUPPLY = 10_000_000 * 10 ** 18; // 10 juta token dengan 18 desimal

    constructor(address initialOwner)
        ERC20("BlackSwan", "BSW")
        Ownable(initialOwner)
        ERC20Permit("BlackSwan")
    {
        _mint(msg.sender, 1_000_000 * 10 ** decimals()); // Mint 1 juta token awal
    }

    function mint(address to, uint256 amount) public onlyOwner {
        require(totalSupply() + amount <= MAX_SUPPLY, "Exceeds maximum supply");
        _mint(to, amount);
    }

    function _update(address from, address to, uint256 value) internal override {
        // Burn 0.50% dari jumlah token yang ditransfer
        uint256 burnAmount = (value * 50) / 10000; // 0.50% = 50 basis poin
        uint256 amountAfterBurn = value - burnAmount;

        super._update(from, to, amountAfterBurn); // Transfer sisa token
        if (burnAmount > 0) {
            _burn(from, burnAmount); // Burn token dari pengirim
        }
    }
}
