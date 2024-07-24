// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
contract Donation {
        address payable owner;
        uint256 balance;
    struct Donor {
        address donor;
        string name;
        uint256 amount;
    }
    Donor[] public donors;
    mapping(address => Donor) public getDonor;
    event donated(address donor, string name, uint256 amount);
    event received(address donor, string name, uint256 amount);
    modifier onlyDonor() {
        require(owner != msg.sender, "only donor can donate");
        _;
    }
    modifier onlyOwner() {
        require(owner == msg.sender, "only owner required");
        _;
    }
    constructor() {
        owner = payable(msg.sender);
    }
    function donate(
        address _donor,
        string memory _name,
        uint256 _amount
    ) public payable onlyDonor {
        require(msg.value % 1 ether == 0, "ETH tokens only!");
        require(msg.value > 0 ether, "amount must be greater than 0!");
        _amount = msg.value;
        Donor storage dn = getDonor[_donor];
        dn.donor = _donor;
        dn.name = _name;
        dn.amount = _amount;
        owner.transfer(_amount);
        emit donated(_donor, _name, _amount);
    }
    function receiveDonations(address _donor) public payable onlyOwner returns (uint256) {
        Donor storage dn = getDonor[_donor];
        balance += dn.amount;
        emit received(dn.donor, dn.name, dn.amount);
        return balance;
    }
    function viewDonations(address _donor) public view returns (address, uint256, uint256) {
        Donor storage dn = getDonor[_donor];
        return (dn.donor, dn.amount, balance);
    }
}
