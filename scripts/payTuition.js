// payTuition.js

const TuitionPayment = artifacts.require('TuitionPayment');

module.exports = async function(callback) {
    try {
        const tuitionPayment = await TuitionPayment.deployed();

        // Example tuition payment amount (total fee minus scholarship)
        const paymentAmount = web3.utils.toWei('2', 'ether');  // 2 ETH after applying scholarship

        console.log(`Paying tuition with amount: ${web3.utils.fromWei(paymentAmount, 'ether')} ETH`);

        // Call the payTuition function in the smart contract
        await tuitionPayment.payTuition({ from: web3.eth.accounts[0], value: paymentAmount });

        console.log("Tuition payment successful!");
        callback();
    } catch (error) {
        console.error("Error paying tuition:", error);
        callback(error);
    }
};
