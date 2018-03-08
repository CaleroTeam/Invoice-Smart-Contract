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

}