// repayLoan.js

const LoanRepayment = artifacts.require('LoanRepayment');

module.exports = async function(callback) {
    try {
        const loanRepayment = await LoanRepayment.deployed();

        // Example repayment amount
        const repaymentAmount = web3.utils.toWei('1', 'ether');  // 1 ETH repayment

        console.log(`Repaying loan with amount: ${web3.utils.fromWei(repaymentAmount, 'ether')} ETH`);

        // Call the repayLoan function in the smart contract
        await loanRepayment.repayLoan(repaymentAmount, { from: web3.eth.accounts[0] });

        console.log("Loan repayment successful!");
        callback();
    } catch (error) {
        console.error("Error repaying loan:", error);
        callback(error);
    }
};
