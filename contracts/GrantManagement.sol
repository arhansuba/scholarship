// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GrantManagement {
    address public admin;
    mapping(address => uint256) public grantAmounts;
    mapping(address => bool) public grantReceived;

    event GrantApproved(address indexed student, uint256 amount);

    constructor() {
        admin = msg.sender;
    }

    // Apply for a grant
    function applyForGrant(uint256 amount) external {
        require(grantReceived[msg.sender] == false, "Grant already received");
        grantAmounts[msg.sender] = amount;

        emit GrantApproved(msg.sender, amount);
    }

    // Disburse grant to the student
    function disburseGrant(address student) external {
        require(msg.sender == admin, "Only admin can disburse grants");
        require(grantAmounts[student] > 0, "No grant to disburse");

        grantReceived[student] = true;

        // ERC20 logic to transfer grant funds would go here
        // ERC20(grantToken).transfer(student, grantAmounts[student]);
    }
}
