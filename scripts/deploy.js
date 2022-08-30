const { ethers, upgrades } = require("hardhat");

async function main() {
const Factory = await ethers.getContractFactory('Staking');

    const factory = await upgrades.deployProxy(Factory, [
        "0x31789ec766c4a06ED9CF49Ea8366229ba920DB74",
        "0x3899d2c3FCdd47b1Bc75a3DAeeFAb7380E1f02A1",
        "0x777A68032a88E5A84678A77Af2CD65A7b3c0775a",
        1080901400000000
    ], {kind: 'uups'});

    console.log("Proxy contract address:", factory.address);
}

main()
    .then(() => {
        process.exit(0)
    })
    .catch(err => {
        console.log(err);
        process.exit(1);
    })