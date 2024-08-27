// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IGrantManagement {
    function applyForGrant(address student, uint256 amount) external;

    function checkGrantStatus(address student) external view returns (bool);

    function distributeGrant(address student, uint256 amount) external;
}
