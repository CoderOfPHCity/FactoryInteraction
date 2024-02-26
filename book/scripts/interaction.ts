import { ethers } from "hardhat";

async function main() {

  const TokenAddress = "0x4559364995E49514981787b25C8bf32B77668e1C";
  const LibraryContractAddress = "0xF57865E399E75199b8560F793Cc0FdCCa1209E06";

 const LibraryFactory = await ethers.getContractAt("IFactory", LibraryContractAddress);

 const tx = await LibraryFactory.createLibrary(TokenAddress)
    await tx.wait();

    const getLibrary = await LibraryFactory.getLibraries()
  
    console.log(getLibrary);

}
  

    main().catch((error) => {
        console.error(error);
        process.exitCode = 1;
      });


    
// token  0x4559364995E49514981787b25C8bf32B77668e1C
// LibraryFactoryaddress 0xF57865E399E75199b8560F793Cc0FdCCa1209E06
// Transaction hash 0xF57865E399E75199b8560F793Cc0FdCCa1209E06



// result = '0xec14B1fFAF76714446e3386A0ba110Ca05FB006c'
