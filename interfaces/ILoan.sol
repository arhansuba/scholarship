// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ILoanRepayment {
    function repayLoan(uint256 amount) external;

    function checkLoanBalance(address student) external view returns (uint256);

    function isLoanFullyPaid(address student) external view returns (bool);
}
