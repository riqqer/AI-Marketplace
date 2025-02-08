const fs = require('fs');
const path = require('path');

async function main() {
    const [deployer, secondAccount] = await hre.ethers.getSigners();
    console.log("Deploying contracts with the account:", deployer.address);

    // Deploy MarketplaceToken contract
    console.log("Deploying MarketplaceToken...");
    const Token = await hre.ethers.getContractFactory("MarketplaceToken");
    const initialSupply = hre.ethers.parseEther("10000"); // 1M tokens
    const token = await Token.deploy(initialSupply);
    await token.waitForDeployment();
    console.log("MarketplaceToken deployed to:", token.target);

    // Deploy AIModelMarketplace contract
    console.log("Deploying AIModelMarketplace...");
    const Marketplace = await hre.ethers.getContractFactory("AIModelMarketplace");
    const marketplace = await Marketplace.deploy(token.target);
    await marketplace.waitForDeployment();
    console.log("AIModelMarketplace deployed to:", marketplace.target);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});