pragma solidity ^0.4.18;

import "./Ownable.sol";
import "./Company.sol";

contract CaleroMain is Ownable {

    mapping(address => bool) invoices;
    mapping(address => bool) companies;

    address[] invoicesList;
    address[] companiesList;

    event InvoiceCreated(address invoice);
    event CompanyRegistered(address company);

    // Add invoice to platform
    function addInvoice(
        address invoice) public {
        invoices[invoice] = true;
        invoicesList.push(invoice);

        InvoiceCreated(invoice);
    }

    // List od all invoices
    function listInvoices() public constant returns (address[]) {
        return invoicesList;
    }

    // Create a new company
    function createCompany(
        string country,
        string name,
        string address1,
        string address2,
        string city,
        uint postalCode) public returns (address) {
        // Call a smart contract for company
        address company = new Company(msg.sender, address(this), country, name, address1, address2, city, postalCode);

        companies[company] = true;
        companiesList.push(company);

        CompanyRegistered(company);
        return company;
    }

    // List of all registered companies
    function listCompanies() public constant returns (address[]) {
        return companiesList;
    }

    // kill the contract
    function kill() public onlyOwner {
        selfdestruct(owner);
    }

}