// SPDX-License-Identifier: MIT

pragma solidity ^0.8.6;

interface IDEC {
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
  ) external;

  ///@notice all people can invest in enterprise to gain part percent of enterprise
  ///@param enterpriseId key id of enterprise you want to invest
  function investInEnterprise(uint256 enterpriseId) external payable;

  ///@notice all investissors can refound her parts
  ///@param enterpriseId key id of enterprise you want to refund your part
  ///@param value value in wei you want refound of your part
  function refoundInvest(uint256 enterpriseId, uint256 value) external;

  ///@notice validate end of crowdfunding of your enterprise
  ///@param enterpriseId key id of enterprise you want to validate
  function validateAtEnd(uint256 enterpriseId) external;

  ///@notice investissor can retrieve percent of enterprise investissed in wei
  ///@param enterpriseId key id of enterprise you want to retrieve investissment
  ///@param percent percent of enterprise investissment you want retrieve
  function investissorTakePercent(uint256 enterpriseId, uint256 percent) external;

  ///@notice founder send a request to retrieve founds
  ///@param enterpriseId key id of enterprise you want to retrieve found
  ///@param request found in wei you want to retrieve
  function founderRequestFounds(uint256 enterpriseId, uint256 request) external;

  ///@notice investissors accept request of founder to retrieve founds
  ///@param enterpriseId key id of enterprise you want to validate request found
  function investissorsAcceptRequest(uint256 enterpriseId) external;

  ///@notice founder retrieve request of found validated by investissors
  ///@param enterpriseId key id of enterprise you want to validate request found
  function founderClaimFounds(uint256 enterpriseId) external;

  ///@notice founder send founds into enterprise
  ///@param enterpriseId key id of enterprise you want to send founds
  function founderSendFounds(uint256 enterpriseId) external payable;
}
