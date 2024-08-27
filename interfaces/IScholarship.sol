// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IScholarship {
    function applyForScholarship(uint256 gpa) external;

    function calculateScholarshipAmount(uint256 gpa) external pure returns (uint256);

    function applyForLoan(uint256 gpa) external;

    function repayLoan(uint256 amount) external;

    function payTuition() external payable;

    function setTuitionFee(uint256 _tuitionFee) external;

    function setLoanInterestRate(uint256 _interestRate) external;
}
