// SPDX-License-Identifier: MIT

// Into the Metaverse NFTs are governed by the following terms and conditions: https://a.did.as/into_the_metaverse_tc

pragma solidity ^0.8.6;

import "@openzeppelin/contracts/access/Ownable.sol";

contract DEC is Ownable {
  mapping(uint256 => Enterprise) enterprises;

  struct Enterprise {
    bytes32 name;
    address owner;
    uint256 founds;
    mapping(address => Investissor) investissors;
  }

  struct Investissor {
    uint256 invest;
  }
}
