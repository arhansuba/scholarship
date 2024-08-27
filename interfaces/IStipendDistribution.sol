// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IStipendDistribution {
    function claimStipend(address student, uint256 stipendAmount) external;

    function checkStipendEligibility(address student) external view returns (bool);

    function setStipendAmount(uint256 amount) external;
}
