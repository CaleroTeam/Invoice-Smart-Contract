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

    // Modifiers
    modifier onlyOwner() {
        require(isOwner(msg.sender));
        _;
    }

    // Add new owner to Seller
    function addOwner(address user) public onlyOwner {
        investor.users[user] = true;
        investor.usersList.push(user);
    }

    // Remove existing owner from Seller
    function removeOwner(address user) public onlyOwner {
        investor.users[user] = false;
        investor.usersList = removeItem(investor.usersList, user);
    }

    // Check if address is owner
    function isOwner(address user) public constant returns (bool) {
        return investor.users[user];
    }

    // List of investor all owners
    function listOwners() public constant returns(address[]) {
        return investor.usersList;
    }

    // Sets investor country
    function setCountry(bytes32 country) public onlyOwner {
        investor.country = country;
    }

    // Sets investor name
    function setName(bytes32 name) public onlyOwner {
        investor.name = name;
    }

    // Sets investor addressStreet
    function setAddressStreet(bytes32 addressStreet) public onlyOwner {
        investor.addressStreet = addressStreet;
    }

    // Sets investor city
    function setCity(bytes32 city) public onlyOwner {
        investor.city = city;
    }

    // Sets investor postalCode
    function setPostalCode(bytes32 postalCode) public onlyOwner {
        investor.postalCode = postalCode;
    }

    // Returns investor country
    function getCountry() public constant returns (bytes32) {
        return investor.country;
    }

    // Returns investor name
    function getName() public constant returns (bytes32) {
        return investor.name;
    }

    // Returns investor address1
    function getAddressStreet() public constant returns (bytes32) {
        return investor.addressStreet;
    }

    // Returns investor city
    function getCity() public constant returns (bytes32) {
        return investor.city;
    }

    // Returns investor postalCode
    function getPostalCode() public constant returns (bytes32) {
        return investor.postalCode;
    }

    /*
    * @dev kill the contract functionality
    */
    function kill() public onlyOwner {
        selfdestruct(msg.sender);
    }
}