const Spacebear = artifacts.require("Spacebear");

//Truffle has the following function to deploy the contracts, run the migratios on teh test chain, and then give you the accounts
contract("Spacebear", (accounts) => {
  it("should credit an NFT to a specific account", async () => {
    const spacebearInstance = await Spacebear.deployed();
    await spacebearInstance.safeMint(accounts[1], "spacebear_1.json");

    //instead of using a console.log, we can use the assert.equal to compare the 2 arguments, and return an error message if unequal
    assert.equal(
      await spacebearInstance.ownerOf(0),
      accounts[1],
      "Owner of Token 1 is not equal to account 2"
    );
  });
});
