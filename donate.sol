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
    event received(address donor, uint256 amount);
    constructor() {
        owner = payable(msg.sender);
    }
    function receiveDonations() public payable {
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
