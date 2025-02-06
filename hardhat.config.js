require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.20",
  networks: {
    ganache: {
      url: "http://127.0.0.1:8545", 
      accounts: [
        "0xd1b22a3b2eb77f14919b094c15b22d4f1ab3abdf5ad19cd93fc6c6c847f8ca45",
        "0x383b2fd058add6edef9cbdc28441caf073de17991fa6261034412bc6d5bb0cf4"
      ],
      ens: { enabled: false },
    },
  },
};
