// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
contract Donation {
        address payable owner;
        uint256 totalDonations;
    struct Donor {
        address donor;
        uint256 amount;
    }
    Donor dnr;
    Donor[] public donors;
    mapping(address => Donor) public getDonor;
    event donated(address donor, uint256 amount);
    event received(address donor, uint256 amount);
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
        uint256 _amount
    ) public payable onlyDonor {
        require(msg.value % 1 ether == 0, "ETH tokens only!");
        require(msg.value > 0 ether, "amount must be greater than 0!");
        _amount = msg.value;
        Donor storage dn = getDonor[_donor];
        dn.donor = _donor;
        dn.amount = _amount;
        owner.transfer(_amount);
        emit donated(_donor, _amount);
    }
    function receiveDonations() public payable onlyOwner {
        dnr = Donor(
         msg.sender,msg.value
        );
        donors.push(dnr);
        totalDonations += msg.value;
    }
    function getDonations() public view returns (Donor[] memory) {
       return donors;
    }
    function gettotalDonations() public view returns (uint256){
        return totalDonations;
    }
}
