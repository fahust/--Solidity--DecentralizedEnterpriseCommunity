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

  uint256 countEnterprises;
  uint256 constant MAXBPS = 1000000;

  event sendFunds(uint256 indexed enterpriseId, uint256 value, address sender);

  modifier isFounder(uint256 enterpriseId) {
    require(_msgSender() == enterprises[enterpriseId].founder, "you are not founder");
    _;
  }

  modifier isValidated(uint256 enterpriseId) {
    require(_msgSender() == enterprises[enterpriseId].founder, "you are not founder");
    _;
  }

  modifier inCrowdfunding(uint256 enterpriseId){
    require(
      block.timestamp >= enterprises[enterpriseId].startAt &&
        block.timestamp <= enterprises[enterpriseId].endAt
    );
    _;
  }

  ///@notice create an enterprise
  ///@param name bytes 32 of enterprise's name
  ///@param startAt uint256 timestamp of start date crowdfunding enterprise project
  ///@param endAt uint256 timestamp of end data crowdfunding enterprise project
  ///@param minVote uint256 0 to 100, needed vote, for owner validation take funds
  function createEnterprise(
    bytes32 name,
    uint256 startAt,
    uint256 endAt,
    uint256 minVote
  ) external {
    Enterprise storage enterprise = enterprises[countEnterprises];
    enterprise.name = name;
    enterprise.startAt = startAt;
    enterprise.endAt = endAt;
    enterprise.minVote = minVote;
    enterprise.founder = _msgSender();
    countEnterprises++;
  }

  ///@notice all people can invest in enterprise to gain part percent of enterprise
  ///@param enterpriseId key id of enterprise you want to invest
  function investInEnterprise(uint256 enterpriseId) external payable inCrowdfunding(enterpriseId) {
    if (enterprises[enterpriseId].investissors[_msgSender()].invest == 0)
      enterprises[enterpriseId].investissorsAddresses.push(_msgSender());
    enterprises[enterpriseId].founds += msg.value;
    enterprises[enterpriseId].investissors[_msgSender()].invest += msg.value;
  }

  ///@notice all investissors can refound her parts
  ///@param enterpriseId key id of enterprise you want to refund your part
  ///@param value value in wei you want refound of your part
  function refoundInvest(uint256 enterpriseId, uint256 value) external inCrowdfunding(enterpriseId) {
    require(enterprises[enterpriseId].investissors[_msgSender()].invest >= value);
    enterprises[enterpriseId].founds -= value;
    enterprises[enterpriseId].investissors[_msgSender()].invest -= value;
    (bool success, ) = payable(_msgSender()).call{ value: value }("");
    require(success == true, "transaction not succeded");
  }

  ///@notice validate end of crowdfunding of your enterprise
  ///@param enterpriseId key id of enterprise you want to validate
  function validateAtEnd(uint256 enterpriseId) external isFounder(enterpriseId) {
    require(block.timestamp >= enterprises[enterpriseId].endAt);
    require(enterprises[enterpriseId].validated == false);
    address[] memory investAddr = enterprises[enterpriseId].investissorsAddresses;
    for (uint256 i = 0; i < investAddr.length; i++) {
      enterprises[enterpriseId].investissors[investAddr[i]].percent =
        (enterprises[enterpriseId].investissors[investAddr[i]].invest * MAXBPS) /
        (enterprises[enterpriseId].founds * MAXBPS);
    }
    enterprises[enterpriseId].validated = true;
  }

  ///@notice investissor can retrieve percent of enterprise investissed in wei
  ///@param enterpriseId key id of enterprise you want to retrieve investissment
  ///@param percent percent of enterprise investissment you want retrieve
  function investissorTakePercent(uint256 enterpriseId, uint256 percent)
    external
    isValidated(enterpriseId)
  {
    require(block.timestamp >= enterprises[enterpriseId].endAt);
    require(enterprises[enterpriseId].investissors[_msgSender()].percent >= percent);
    enterprises[enterpriseId].investissors[_msgSender()].percent -= percent;
    uint256 value = enterprises[enterpriseId].founds /
      enterprises[enterpriseId].investissors[_msgSender()].percent;
    require(enterprises[enterpriseId].founds >= value);
    enterprises[enterpriseId].founds -= value;
    (bool success, ) = payable(_msgSender()).call{ value: value }("");
    require(success == true, "transaction not succeded");
  }

  ///@notice founder send a request to retrieve founds
  ///@param enterpriseId key id of enterprise you want to retrieve found
  ///@param request found in wei you want to retrieve
  function founderRequestFounds(uint256 enterpriseId, uint256 request)
    external
    isFounder(enterpriseId)
    isValidated(enterpriseId)
  {
    require(enterprises[enterpriseId].founds >= enterprises[enterpriseId].request);
    enterprises[enterpriseId].request = request;
  }

  ///@notice investissors accept request of founder to retrieve founds
  ///@param enterpriseId key id of enterprise you want to validate request found
  function investissorsAcceptRequest(uint256 enterpriseId)
    external
    isValidated(enterpriseId)
  {
    require(enterprises[enterpriseId].investissors[_msgSender()].percent > 0);
    enterprises[enterpriseId].validations[_msgSender()].percent = enterprises[
      enterpriseId
    ].investissors[_msgSender()].percent;
  }

  ///@notice founder retrieve request of found validated by investissors
  ///@param enterpriseId key id of enterprise you want to validate request found
  function founderClaimFounds(uint256 enterpriseId)
    external
    isFounder(enterpriseId)
    isValidated(enterpriseId)
  {
    uint256 percentValidated;
    address[] memory investAddr = enterprises[enterpriseId].investissorsAddresses;
    for (uint256 i = 0; i < investAddr.length; i++) {
      percentValidated += enterprises[enterpriseId].validations[investAddr[i]].percent;
    }
    require(
      percentValidated >= enterprises[enterpriseId].minVote,
      "not enough validation points"
    );
    enterprises[enterpriseId].founds -= enterprises[enterpriseId].request;
    (bool success, ) = payable(_msgSender()).call{
      value: enterprises[enterpriseId].request
    }("");
    require(success == true, "transaction not succeded");
  }

  ///@notice founder send founds into enterprise
  ///@param enterpriseId key id of enterprise you want to send founds
  function founderSendFounds(uint256 enterpriseId)
    external
    payable
    isFounder(enterpriseId)
    isValidated(enterpriseId)
  {
    enterprises[enterpriseId].founds += msg.value;
    emit sendFunds(enterpriseId, msg.value, _msgSender());
  }

}
