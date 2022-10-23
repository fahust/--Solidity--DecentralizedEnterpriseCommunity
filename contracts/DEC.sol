// SPDX-License-Identifier: MIT

// Into the Metaverse NFTs are governed by the following terms and conditions: https://a.did.as/into_the_metaverse_tc

pragma solidity ^0.8.6;

import "@openzeppelin/contracts/access/Ownable.sol";

contract DEC is Ownable {
  mapping(uint256 => Enterprise) enterprises;

  struct Enterprise {
    bytes32 name;
    address founder;
    uint256 founds;
    mapping(address => Investissor) investissors;
  }

  struct Investissor {
    uint256 invest;
  }

  uint256 countEnterprises;

  modifier isFounder(uint256 enterpriseId) {
    require(_msgSender() == enterprises[enterpriseId].founder, "you are not founder");
    _;
  }

  function createEnterprise(bytes32 name) external {
    Enterprise storage enterprise = enterprises[countEnterprises];
    enterprise.name = name;
    enterprise.founder = _msgSender();
    countEnterprises++;
  }

  function investInEnterprise(uint256 enterpriseId) external payable {
    enterprises[enterpriseId].investissors[_msgSender()].invest += msg.value;
  }
}
