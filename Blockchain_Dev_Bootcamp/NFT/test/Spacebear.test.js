const Spacebear = artifacts.require("Spacebear");

//Truffle has the following function to deploy the contracts, run the migratios on teh test chain, and then give you the accounts
contract("Spacebear", (accounts) => {
  it("should credit an NFT to a specific account", async () => {
    const spacebearInstance = await Spacebear.deployed();
    await spacebearInstance.safeMint(accounts[1], "spacebear_1.json");
    console.log(await spacebearInstance.ownerOf(0));
  });
});
