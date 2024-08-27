// applyGrant.js

const GrantManagement = artifacts.require('GrantManagement');

module.exports = async function(callback) {
    try {
        const grantManagement = await GrantManagement.deployed();

        // Example grant application
        const grantAmount = web3.utils.toWei('3', 'ether');  // 3 ETH grant request

        console.log(`Applying for grant with amount: ${web3.utils.fromWei(grantAmount, 'ether')} ETH`);

        // Call the applyForGrant function in the smart contract
        await grantManagement.applyForGrant(web3.eth.accounts[0], grantAmount, { from: web3.eth.accounts[0] });

        console.log("Grant application successful!");
        callback();
    } catch (error) {
        console.error("Error applying for grant:", error);
        callback(error);
    }
};
