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
    uint256 startAt;
    uint256 endAt;
    address[] investissorsAddresses;
    mapping(address => Investissor) investissors;
  }

  struct Investissor {
    uint256 invest;
    uint256 percent;
  }

  uint256 countEnterprises;

  modifier isFounder(uint256 enterpriseId) {
    require(_msgSender() == enterprises[enterpriseId].founder, "you are not founder");
    _;
  }

  function createEnterprise(
    bytes32 name,
    uint256 startAt,
    uint256 endAt
  ) external {
    Enterprise storage enterprise = enterprises[countEnterprises];
    enterprise.name = name;
    enterprise.startAt = startAt;
    enterprise.endAt = endAt;
    enterprise.founder = _msgSender();
    countEnterprises++;
  }

  function validateAtEnd(uint256 enterpriseId) external isFounder(enterpriseId) {
    require(block.timestamp >= enterprises[enterpriseId].endAt);
    address[] memory investAddr = enterprises[enterpriseId].investissorsAddresses;
    for (uint256 i = 0; i < investAddr.length; i++) {
      enterprises[enterpriseId].investissors[investAddr[i]].percent =
        (enterprises[enterpriseId].investissors[investAddr[i]].invest /
          enterprises[enterpriseId].founds) *
        100;
    }
  }

  function investInEnterprise(uint256 enterpriseId) external payable {
    require(
      block.timestamp >= enterprises[enterpriseId].startAt &&
        block.timestamp <= enterprises[enterpriseId].endAt
    );
    if (enterprises[enterpriseId].investissors[_msgSender()].invest == 0)
      enterprises[enterpriseId].investissorsAddresses.push(_msgSender());
    enterprises[enterpriseId].founds += msg.value;
    enterprises[enterpriseId].investissors[_msgSender()].invest += msg.value;
  }

  function refoundInvest(uint256 enterpriseId, uint256 value) external {
    require(enterprises[enterpriseId].investissors[_msgSender()].invest >= value);
    enterprises[enterpriseId].founds -= value;
    enterprises[enterpriseId].investissors[_msgSender()].invest -= value;
    (bool success, ) = payable(_msgSender()).call{ value: value }("");
    require(success == true, "transaction not succeded");
  }
}
