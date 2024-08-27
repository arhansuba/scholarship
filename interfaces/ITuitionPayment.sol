// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ITuitionPayment {
    function payTuition() external payable;

    function getTotalTuitionFee() external view returns (uint256);

    function getScholarshipReduction(address student) external view returns (uint256);

    function setTuitionFee(uint256 _tuitionFee) external;
}
