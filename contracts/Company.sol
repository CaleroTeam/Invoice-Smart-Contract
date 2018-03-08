pragma solidity ^0.4.18;

import "./Operations.sol";

contract Company is Operations {
    struct CompanyStruct {
        // Main smart contract address
        address CaleroMain;

        // Company country, name, addressStreet, city, postal code
        bytes32 country;
        bytes32 addressStreet;
        bytes32 name;
        bytes32 city;
        bytes32 postalCode;

        // Additional info
        mapping (address => bool) users;
        address[] usersList;
    }

    CompanyStruct company;

    // Constructor
    function Company(address owner, address CaleroMain, bytes32 country, bytes32 name, bytes32 addressStreet, bytes32 city, bytes32 postalCode) public {
        company.users[owner] = true;
        company.usersList.push(owner);
        company.CaleroMain = CaleroMain;
        company.country = country;
        company.name = name;
        company.addressStreet = addressStreet;
        company.city = city;
        company.postalCode = postalCode;
    }

    // Modifiers
    modifier onlyOwner() {
        require(isOwner(msg.sender));
        _;
    }

    // Add new owner to company
    function addOwner(address user) public onlyOwner {
        company.users[user] = true;
        company.usersList.push(user);
    }

    // Remove existing owner from company
    function removeOwner(address user) public onlyOwner {
        company.users[user] = false;
        company.usersList = removeItem(company.usersList, user);
    }

    // Check if address is owner
    function isOwner(address user) public constant returns (bool) {
        return company.users[user];
    }

}