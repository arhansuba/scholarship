// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TuitionPayment {
    address public admin;
    uint256 public totalTuitionFee;
    mapping(address => uint256) public tuitionPaid;

    event TuitionPaid(address indexed student, uint256 amount, uint256 totalPaid);

    constructor(uint256 _totalTuitionFee) {
        admin = msg.sender;
        totalTuitionFee = _totalTuitionFee;
    }

    // Pay tuition by the student
    function payTuition(uint256 amount) external {
        require(tuitionPaid[msg.sender] + amount <= totalTuitionFee, "Payment exceeds tuition fee");

        tuitionPaid[msg.sender] += amount;

        emit TuitionPaid(msg.sender, amount, tuitionPaid[msg.sender]);

        // ERC20 logic to transfer tuition payment from student to the contract would go here
        // ERC20(tuitionToken).transferFrom(msg.sender, address(this), amount);
    }

    // Check if the student has fully paid the tuition
    function isTuitionPaid(address student) external view returns (bool) {
        return tuitionPaid[student] >= totalTuitionFee;
    }
}
