//const { BigNumber, ethers } = require("ethers");
//const keccak256 = require("keccak256");
const LEGACY = artifacts.require("LEGACY");
const truffleAssert = require("truffle-assertions");
const { ethers } = require("ethers");

function bytes32FromNumber(number) {
  return ethers.utils.hexZeroPad(ethers.utils.hexlify(number), 32);
}

function numberFromBytes32(bytes32) {
  return parseInt(Number(bytes32));
}

function timeout(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

const advanceBlock = () => {
  return new Promise((resolve, reject) => {
    web3.currentProvider.send(
      {
        jsonrpc: "2.0",
        method: "evm_mine",
        id: new Date().getTime(),
      },
      err => {
        if (err) {
          return reject(err);
        }
        const newBlockHash = web3.eth.getBlock("latest").hash;

        return resolve(newBlockHash);
      },
    );
  });
};

contract("KANJIDROPERC721AWithReceive", async accounts => {
  const leg = {
    name: web3.utils.fromAscii("test de name un poil long").padEnd(66, "0"),
    founder: accounts[0],
    heir: accounts[1],
    startAt: Math.round(Date.now() / 1000) - 103,
    endAt: Math.round(Date.now() / 1000) + 1000,
    lastClaim: 0,
    weiBySeconds: 10,
    founds: 1000,
    //openFounds: 1000,
  };

  before(async function () {
    this.legacy = await LEGACY.new(); // we deploy contract
  });

  describe("", async function () {});
});
