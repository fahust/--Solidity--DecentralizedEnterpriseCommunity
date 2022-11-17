# DECENTRALIZED ENTERPRISE COMMUNITY
<div style="text-align:center"><img src="./doc/Decentralized%20enterprise.png?raw=true" /></div>

## Utils
- **truffle** 5.6.3
- **prettier-plugin-solidity** 1.0.0-rc.1
- **web3-onboard** 2.10.0
- **openzeppelin/contracts** 4.4.1
- **slither**
- **mythril**

### Install library dependancies for local test

```bash
yarn
```

### Start local network with ganache

```bash
yarn ganache
```

### All available commands

The **package.json** file contains a set of scripts to help on the development phase. Below is a short description for each

- **"ganache"** run local node (development network) with ganache-cli
- **"migrate"** run migration on development network
- **"test"** run tests locally
- **"test:ci"** run tests in CI system
- **"lint:sol"** lint solidity code according to rules
- **"lint:js"** lint javascript code according to rules
- **"lint"** lint solidity code
- **"truffle test -- -g "name of test""** run specific test

### Solhint

[You can find rules and explanations here](https://github.com/protofire/solhint/blob/master/docs/rules.md)

## Solidity Good Practices

| Ref | Description |
| --- | --- |
| [Zero knowledge proof](https://docs.zksync.io/userdocs/) | Accelerating the mass adoption of crypto for personal sovereignty |
| [byte32](https://ethereum.stackexchange.com/questions/11556/use-string-type-or-bytes32) | Use strings for dynamically allocated data, otherwise Byte32 is going to perform better. Bytes32 is also going to be better in gas |
| [Use uint instead bool](https://ethereum.stackexchange.com/questions/39932/solidity-bool-size-in-structs) | It's more efficient to pack multiple booleans in a uint256, and extract them with a mask. You can store 256 booleans in a single uint256 |
| [.call()](https://medium.com/coinmonks/solidity-transfer-vs-send-vs-call-function-64c92cfc878a) | using call, one can also trigger other functions defined in the contract and send a fixed amount of gas to execute the function. The transaction status is sent as a boolean and the return value is sent in the data variable. |
| [Interfaces](https://www.tutorialspoint.com/solidity/solidity_interfaces.htm) | Interfaces are most useful in scenarios where your dapps require extensibility without introducing added complexity |
| [Change State Local Variable](https://ethereum.stackexchange.com/questions/118754/is-it-more-gas-efficient-to-declare-variable-inside-or-outside-of-a-for-or-while) | It's cheaper to to declare the variable outside the loop |
| [CallData](https://medium.com/coinmonks/solidity-storage-vs-memory-vs-calldata-8c7e8c38bce) | It is recommended to try to use calldata because it avoids unnecessary copies and ensures that the data is unaltered |
| [Pack your variables](https://mudit.blog/solidity-gas-optimization-tips/) | Packing is done by solidity compiler and optimizer automatically, you just need to declare the packable functions consecutively |
| [Type Function Visibility](https://www.ajaypalcheema.com/function-visibility-in-solidty/#:~:text=There%20are%20four%20types%20of,internal%20%2C%20private%20%2C%20and%20public%20.&text=private%20modifier%20specifies%20that%20this,by%20children%20inheriting%20the%20contract.) |  This is the most restrictive visibility and more gas efficient |
| [Delete Variable](https://mudit.blog/solidity-gas-optimization-tips/) | If you don’t need a variable anymore, you should delete it using the delete keyword provided by solidity or by setting it to its default value |
| [Immutable / constant variable](https://dev.to/jamiescript/gas-saving-techniques-in-solidity-324c) | Use constant and immutable variables for variable that don't change |
| [Unchecked state change](https://www.linkedin.com/pulse/optimizing-smart-contract-gas-cost-harold-achiando/) | Add unchecked {} for subtractions where the operands cannot underflow |
| [Use revert instead of require](https://dev.to/jamiescript/gas-saving-techniques-in-solidity-324c) | Using revert instead of require is more gas efficient |
| [Index events](https://ethereum.stackexchange.com/questions/8658/what-does-the-indexed-keyword-do) | The indexed parameters for logged events will allow you to search for these events using the indexed parameters as filters |
| [Mythril](https://mythril-classic.readthedocs.io/en/master/about.html) | Mythril is a security analysis tool for Ethereum smart contracts |
| [Slither](https://medium.com/coinmonks/automated-smart-contract-security-review-with-slither-1834e9613b01) | Automated smart contract security review with Slither |
| [Reporter gaz](https://www.npmjs.com/package/eth-gas-reporter) | Gas usage per unit test |
| [Hyper ledger factory](https://www.ibm.com/fr-fr/topics/hyperledger) | Hyperledger Fabric, an open source project from the Linux Foundation, is the modular blockchain framework and de facto standard for enterprise blockchain platforms. |
| [Chain link](https://docs.chain.link/getting-started/consuming-data-feeds) | Oracles provide a bridge between the real-world and on-chain smart contracts by being a source of data that smart contracts can rely on, and act upon |
| [UniSwap](https://docs.uniswap.org/sdk/guides/quick-start) | |
| [Reentrancy](https://solidity-by-example.org/hacks/re-entrancy/) | The Reentrancy attack is one of the most destructive attacks in the Solidity smart contract. A reentrancy attack occurs when a function makes an external call to another untrusted contract |
| [Front Running](https://coinsbench.com/front-running-hack-solidity-10-57d0765d0179) | The attacker can execute something called the Front-Running Attack wherein, they basically prioritize their transaction over other users by setting higher gas fees |
| [Delegate Call](https://coinsbench.com/unsafe-delegatecall-part-1-hack-solidity-5-81d5f295edb6) | In order to update the owner of the HackMe contract, we pass the function signature of the pwn function via abi.encodeWithSignature(“pwn()”) from the malicious contract |
| [Self Destruct](https://hackernoon.com/how-to-hack-smart-contracts-self-destruct-and-solidity) | an attacker can create a contract with a selfdestruct() function, send ether to it, call selfdestruct(target) and force ether to be sent to a target |
| [Block Timestamp Manipulation](https://cryptomarketpool.com/block-timestamp-manipulation-attack/) | To prevent this type of attack do not use block.timestamp in your contract or follow the 15 second rule. The 15 second rule states |
| [Phishing with tx.origin](https://hackernoon.com/hacking-solidity-contracts-using-txorigin-for-authorization-are-vulnerable-to-phishing) | Let’s say a call could be made to the vulnerable contract that passes the authorization check since tx.origin returns the original sender of the transaction which in this case is the authorized account |


## CONTRACTS

This contract is a used to create a decentralized enterprise, and allow anyone to invest in it by owning percentages in the company, percentage that can be recovered at any time

## STRUCTURE

```javascript
mapping(uint256 => Enterprise) enterprises;

  struct Enterprise {
    bytes32 name;
    address founder;
    uint256 founds;
    uint256 startAt;
    uint256 endAt;
    uint256 request;
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
```

## SETTER

```javascript
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
```

```javascript
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
```

```javascript
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
```

```javascript
function refoundInvest(uint256 enterpriseId, uint256 value) external {
    require(
      block.timestamp >= enterprises[enterpriseId].startAt &&
        block.timestamp <= enterprises[enterpriseId].endAt
    );
    require(enterprises[enterpriseId].investissors[_msgSender()].invest >= value);
    enterprises[enterpriseId].founds -= value;
    enterprises[enterpriseId].investissors[_msgSender()].invest -= value;
    (bool success, ) = payable(_msgSender()).call{ value: value }("");
    require(success == true, "transaction not succeded");
  }
```

```javascript
function investissorTakePercent(uint256 enterpriseId, uint256 percent) external {
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
```

```javascript
function founderRequestFounds(uint256 enterpriseId, uint256 request)
    external
    isFounder(enterpriseId)
  {
    require(enterprises[enterpriseId].founds >= enterprises[enterpriseId].request);
    enterprises[enterpriseId].request = request;
  }
```

```javascript
function investissorsAcceptRequest(uint256 enterpriseId) external {
    require(enterprises[enterpriseId].investissors[_msgSender()].percent > 0);
    enterprises[enterpriseId].validations[_msgSender()].percent = enterprises[
      enterpriseId
    ].investissors[_msgSender()].percent;
  }
```

```javascript
function founderClaimFounds(uint256 enterpriseId) external isFounder(enterpriseId) {
    uint256 percentValidated;
    address[] memory investAddr = enterprises[enterpriseId].investissorsAddresses;
    for (uint256 i = 0; i < investAddr.length; i++) {
      percentValidated += enterprises[enterpriseId].validations[investAddr[i]].percent;
    }
    require(percentValidated >= 50, "not enough validation points");
    enterprises[enterpriseId].founds -= enterprises[enterpriseId].request;
    (bool success, ) = payable(_msgSender()).call{
      value: enterprises[enterpriseId].request
    }("");
    require(success == true, "transaction not succeded");
  }
```

```javascript

```

## GUETTER
