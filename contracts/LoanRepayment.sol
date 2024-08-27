// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LoanRepayment {
    address public admin;
    mapping(address => uint256) public loanBalances;
    mapping(address => uint256) public repaymentAmounts;

    event LoanRepaid(address indexed student, uint256 amount, uint256 remainingBalance);

    constructor() {
        admin = msg.sender;
    }

    // Record a loan balance when a loan is issued
    function setLoanBalance(address student, uint256 amount) external {
        require(msg.sender == admin, "Only admin can set loan balances");
        loanBalances[student] = amount;
    }

    // Repay loan by the student
    function repayLoan(uint256 amount) external {
        require(loanBalances[msg.sender] > 0, "No loan balance to repay");
        require(amount <= loanBalances[msg.sender], "Repayment exceeds loan balance");

        loanBalances[msg.sender] -= amount;
        repaymentAmounts[msg.sender] += amount;

        emit LoanRepaid(msg.sender, amount, loanBalances[msg.sender]);

        // ERC20 logic to transfer repayment from student to the contract would go here
        // ERC20(loanToken).transferFrom(msg.sender, address(this), amount);
    }

    // View the remaining loan balance
    function getRemainingBalance(address student) external view returns (uint256) {
        return loanBalances[student];
    }
}
