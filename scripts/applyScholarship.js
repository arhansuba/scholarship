// applyScholarship.js

const Scholarship = artifacts.require('Scholarship');
const { validateGPA, formatGPA } = require('../utils/GPAValidator');

module.exports = async function(callback) {
    try {
        const scholarship = await Scholarship.deployed();

        // Example GPA value
        const gpa = 3.2;

        // Validate GPA
        if (!validateGPA(gpa)) {
            console.error("Invalid GPA.");
            return;
        }

        const formattedGPA = formatGPA(gpa);
        console.log(`Applying for a scholarship with GPA: ${formattedGPA}`);

        // Call the applyForScholarship function in the smart contract
        await scholarship.applyForScholarship(formattedGPA, { from: web3.eth.accounts[0] });

        console.log("Scholarship applied successfully!");
        callback();
    } catch (error) {
        console.error("Error applying for scholarship:", error);
        callback(error);
    }
};
