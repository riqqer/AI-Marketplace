require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.20",
  networks: {
    ganache: {
      url: "http://127.0.0.1:8545", 
      accounts: [
        "0xdadecf40b364fb7c3295b6e03ca99212396014062d74e0a46888553966f01b88",
        "0xa880b21861e247948fd56b39fd7ceaff673968c1b782d8ad607ec39ac4dee1fa"
      ],
      ens: { enabled: false },
    },
  },
};
