pragma solidity ^0.4.18;

import "./Operations.sol";

contract Seller {
    struct SellerStruct {
        address CaleroMain;

        // Seller country, name, addressStreet, city, postal code
        bytes32 country;
        bytes32 name;
        bytes32 addressStreet;
        bytes32 city;
        bytes32 postalCode;

        // Additional info
        mapping (address => bool) users;
        address[] usersList;
    }

    SellerStruct investor;

    // Constructor
    function Seller(address owner, address CaleroMain, bytes32 country, bytes32 name, bytes32 addressStreet, bytes32 city, bytes32 postalCode) public {
        investor.users[owner] = true;
        investor.usersList.push(owner);
        investor.CaleroMain = CaleroMain;
        investor.country = country;
        investor.name = name;
        investor.addressStreet = addressStreet;
        investor.city = city;
        investor.postalCode = postalCode;
    }

}