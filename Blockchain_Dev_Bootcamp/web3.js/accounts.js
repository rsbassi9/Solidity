// Anonymous function to return teh accounts and their balance, depending on which environment is being used - local or metamask
(async () => {
  let accounts = await web3.eth.getAccounts();
  console.log(accounts, accounts.length);
  let balance = await web3.eth.getBalance(accounts[0]);
  console.log(balance);
  // On metamask, you can convert the Wei to Eth using:
  console.log(web3.utils.formWei(balance, "ether"));
})();
