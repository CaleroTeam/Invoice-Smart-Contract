pragma solidity ^0.4.18;

import "./CaleroPlatform.sol";
import "./Invoice.sol";

contract Company {
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

    // List of company all owners
    function listOwners() public constant returns(address[]) {
        return company.usersList;
    }

    // Sets user country
    function setCountry(bytes32 country) public onlyOwner {
        company.country = country;
    }

    // Sets user name
    function setName(bytes32 name) public onlyOwner {
        company.name = name;
    }

    // Sets user address1
    function setAddressStreet(bytes32 addressStreet) public onlyOwner {
        company.addressStreet = addressStreet;
    }

    // Sets user city
    function setCity(bytes32 city) public onlyOwner {
        company.city = city;
    }

    // Sets user postalCode
    function setPostalCode(bytes32 postalCode) public onlyOwner {
        company.postalCode = postalCode;
    }

    // Returns user country
    function getCountry() public constant returns (bytes32) {
        return company.country;
    }

    // Returns user name
    function getName() public constant returns (bytes32) {
        return company.name;
    }

    // Returns user addressStreet
    function getAddressStreet() public constant returns (bytes32) {
        return company.addressStreet;
    }

    // Returns user city
    function getCity() public constant returns (bytes32) {
        return company.city;
    }

    // Returns user postalCode
    function getPostalCode() public constant returns (bytes32) {
        return company.postalCode;
    }
    
    /*
    * @dev kill the contract functionality
    */
    function kill() public onlyOwner {
        selfdestruct(msg.sender);
    }
}