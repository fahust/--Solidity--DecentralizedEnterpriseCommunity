// SPDX-License-Identifier: MIT
// EnterpriseLib contract
pragma solidity ^0.8.0;

library EnterpriseLib {
  struct Enterprise {
    bytes32 name;
    address founder;
    uint256 founds;
    uint256 startAt;
    uint256 endAt;
    uint256 request;
    uint256 minVote;
    bool validated;
    address[] investissorsAddresses;
    mapping(address => Validation) validations;
    mapping(address => Investissor) investissors;
  }

  struct Investissor {
    uint256 invest;
    uint256 percent;
  }

  struct Validation {
    uint256 percent;
  }
}