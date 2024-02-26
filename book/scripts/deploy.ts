import { ethers } from "hardhat";

async function main() {

const token = await ethers.deployContract("Token");

  await token.waitForDeployment();

  console.log(`Token deployed to ${token.target}`);


  const cooperateLibraryFactory = await ethers.deployContract("LibraryFactory");

  await cooperateLibraryFactory.waitForDeployment();
  
  console.log(`CooperateBank deployed to ${cooperateLibraryFactory.target}`);
  
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});


// token  0x4559364995E49514981787b25C8bf32B77668e1C
// LibraryFactoryaddress 0xF57865E399E75199b8560F793Cc0FdCCa1209E06
