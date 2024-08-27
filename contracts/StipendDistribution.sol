// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StipendDistribution {
    address public admin;
    uint256 public monthlyStipend;
    mapping(address => uint256) public lastClaimedMonth;

    event StipendClaimed(address indexed student, uint256 month, uint256 amount);

    constructor(uint256 _monthlyStipend) {
        admin = msg.sender;
        monthlyStipend = _monthlyStipend;
    }

    // Students claim their stipend each month
    function claimStipend(uint256 month) external {
        require(lastClaimedMonth[msg.sender] < month, "Stipend already claimed for this month");

        lastClaimedMonth[msg.sender] = month;

        emit StipendClaimed(msg.sender, month, monthlyStipend);

        // ERC20 logic to transfer stipend to the student would go here
        // ERC20(stipendToken).transfer(msg.sender, monthlyStipend);
    }

    // Admin can change the monthly stipend amount
    function setMonthlyStipend(uint256 amount) external {
        require(msg.sender == admin, "Only admin can change stipend amount");
        monthlyStipend = amount;
    }
}
