const { expect } = require("chai");
const {ethers} = require("hardhat");

describe("Vote contract", function () {

  it("Check Votee function", async function() {

    const [owner,addr1] = await ethers.getSigners();

    const vote = await ethers.getContractFactory("Vote");

    const Deloy = await vote.deploy();

    const addNominee = await Deloy.AddNominee(addr1.address);

    const Register = await Deloy.Register(owner.address);

    const BalanceAddr1Before = await Deloy.Balance(addr1.address);

    const Voter = await Deloy.Votee(addr1.address);

    const BalanceAddr1After = await Deloy.Balance(addr1.address);

    expect(BalanceAddr1Before).to.equal(BalanceAddr1After - 1 );
  });

});