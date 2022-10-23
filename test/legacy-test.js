//const { BigNumber, ethers } = require("ethers");
//const keccak256 = require("keccak256");
const DEC = artifacts.require("DEC");
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

  before(async function () {
    this.dec = await DEC.new(); // we deploy contract
  });

  describe("", async function () {});
});
