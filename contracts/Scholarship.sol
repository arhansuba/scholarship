// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Scholarship {
    address public admin;
    uint256 public loanInterestRate; // Loan interest rate as a percentage (e.g., 5% = 5)
    uint256 public tuitionFee = 1000 ether; // Example tuition fee for simplicity
    
    mapping(address => uint256) public scholarshipAmounts;
    mapping(address => uint256) public loanAmounts;
    mapping(address => bool) public hasLoan;
    mapping(address => bool) public hasScholarship;

    constructor(uint256 _loanInterestRate) {
        admin = msg.sender;
        loanInterestRate = _loanInterestRate; // Set loan interest rate
    }

    // Apply for scholarship based on GPA
    function applyForScholarship(uint256 gpa) external {
        require(gpa >= 2.0, "GPA too low for any scholarship");
        require(!hasScholarship[msg.sender], "Scholarship already granted");

        uint256 scholarshipAmount = calculateScholarshipAmount(gpa);
        scholarshipAmounts[msg.sender] = scholarshipAmount;
        hasScholarship[msg.sender] = true;
    }

    // Calculate scholarship amount based on GPA
    function calculateScholarshipAmount(uint256 gpa) internal pure returns (uint256) {
        if (gpa >= 3.5) {
            return 100; // 100% scholarship
        } else if (gpa >= 3.0) {
            return 75; // 75% scholarship
        } else if (gpa >= 2.5) {
            return 50; // 50% scholarship
        } else if (gpa >= 2.0) {
            return 25; // 25% scholarship
        } else {
            return 0; // No scholarship
        }
    }

    // Apply for a student loan if GPA is high enough
    function applyForLoan(uint256 gpa) external {
        require(gpa >= 3.0, "GPA too low for loan approval");
        require(!hasLoan[msg.sender], "Loan already granted");

        // Calculate loan amount (here it's a fixed loan for simplicity)
        uint256 loanAmount = calculateLoanAmount(gpa);
        loanAmounts[msg.sender] = loanAmount;
        hasLoan[msg.sender] = true;
    }

    // Calculate loan amount based on GPA
    function calculateLoanAmount(uint256 gpa) internal pure returns (uint256) {
        if (gpa >= 3.5) {
            return 1000 ether; // Max loan
        } else if (gpa >= 3.0) {
            return 500 ether; // Half loan
        }
        return 0;
    }

    // Loan repayment function
    function repayLoan(uint256 amount) external {
        require(hasLoan[msg.sender], "No loan to repay");
        require(loanAmounts[msg.sender] >= amount, "Overpayment");

        // Decrease the loan amount by the repaid value
        loanAmounts[msg.sender] -= amount;

        if (loanAmounts[msg.sender] == 0) {
            hasLoan[msg.sender] = false; // Loan fully repaid
        }
    }

    // Pay tuition by subtracting scholarship and loan
    function payTuition() external payable {
        uint256 scholarshipAmount = (scholarshipAmounts[msg.sender] * tuitionFee) / 100;
        uint256 totalDue = tuitionFee - scholarshipAmount;
        require(msg.value == totalDue, "Incorrect tuition amount");
    }

    // Only admin can set tuition fees
    function setTuitionFee(uint256 _tuitionFee) external {
        require(msg.sender == admin, "Only admin can set tuition fee");
        tuitionFee = _tuitionFee;
    }

    // Only admin can set loan interest rates
    function setLoanInterestRate(uint256 _interestRate) external {
        require(msg.sender == admin, "Only admin can set loan interest rate");
        loanInterestRate = _interestRate;
    }
}
