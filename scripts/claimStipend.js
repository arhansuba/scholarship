// claimStipend.js

const StipendDistribution = artifacts.require('StipendDistribution');

module.exports = async function(callback) {
    try {
        const stipendDistribution = await StipendDistribution.deployed();

        // Example stipend amount
        const stipendAmount = web3.utils.toWei('0.5', 'ether');  // 0.5 ETH stipend

        console.log(`Claiming stipend with amount: ${web3.utils.fromWei(stipendAmount, 'ether')} ETH`);

        // Call the claimStipend function in the smart contract
        await stipendDistribution.claimStipend(web3.eth.accounts[0], stipendAmount, { from: web3.eth.accounts[0] });

        console.log("Stipend claimed successfully!");
        callback();
    } catch (error) {
        console.error("Error claiming stipend:", error);
        callback(error);
    }
};
