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

}