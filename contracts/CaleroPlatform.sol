pragma solidity ^0.4.18;

import "./Ownable.sol";

contract CaleroPlatform is Ownable {
    uint nextInvoiceId = 0;

    mapping (address => bool) invoices;
    address[] invoicesList;

    mapping (address => bool) companies;
    address[] companiesList;

    mapping (address => bool) sellers;
    address[] sellersList;

    event InvoiceCreated(address invoice);
    event CompanyRegistered(address company);
    event SellerRegistered(address seller);

    // Add invoice to platform Invoices list
    function addInvoice(address invoice) public {
        invoices[invoice] = true;
        invoicesList.push(invoice);
        InvoiceCreated(invoice); // event
    }

    // List all invoices
    function listInvoices() public constant returns (address[]) {
        return invoicesList;
    }

    // Create new company
    function createCompany(bytes32 country, bytes32 name, bytes32 addressStreet, bytes32 city, bytes32 postalCode) public returns (address) {
        address company = new Company(msg.sender, address(this), country, name, addressStreet, city, postalCode);
        companies[company] = true;
        companiesList.push(company);
        CompanyRegistered(company); // event

        return company;
    }

    // List of all registered companies
    function listCompanies() public constant returns (address[]) {
        return companiesList;
    }

    // Create new Seller
    function createSellers(bytes32 country, bytes32 name, bytes32 addressStreet, bytes32 city, bytes32 postalCode) public returns (address) {
        address seller = new Seller(msg.sender, address(this), country, name, addressStreet, city, postalCode);
        sellers[seller] = true;
        sellersList.push(seller);

        SellerRegistered(seller);
        return seller;
    }

    // List of all registered sellers
    function listSellers() public constant returns (address[]) {
        return sellersList;
    }   /*
    * @dev kill the contract functionality
    */

    function kill() public onlyOwner {
        selfdestruct(owner);
    }
}