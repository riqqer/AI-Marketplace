require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.20",
  networks: {
    ganache: {
      url: "http://127.0.0.1:8545", 
      accounts: [
        "0x3de660e8b51227341d987c9a6320e75c9ffb9ed7294bc81f516bd3ac7365684d",
        "0xb0e39b91ddf4508cbe1369ebf2fc85d4d11c3c37afeace0fc6c25be6e13af873"
      ],
      ens: { enabled: false },
    },
  },
};
