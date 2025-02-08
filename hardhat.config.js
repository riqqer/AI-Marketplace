require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.20",
  networks: {
    ganache: {
      url: "http://127.0.0.1:8545", 
      accounts: [
        "0x3bb874955d3b7a3aed80fd03f6e00112197d22021d9f43d6af61586175b6a08b",
        "0xc89a2a0bff6a6b87c282bf992a0d80cb51186853a1c0c95f0597ebb437402241"
      ],
      ens: { enabled: false },
    },
  },
};
