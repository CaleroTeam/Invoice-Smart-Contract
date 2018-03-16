pragma solidity ^0.4.18;

import "./CaleroPlatform.sol";
import "./Invoice.sol";

contract Company {

    struct CompanyStruct {
        address caleroMain;
        string country;
        string name;
        string address1;
        string address2;
        string city;
        uint postalCode;
        mapping(address => bool) users;
        address[] usersList;
    }

    CompanyStruct company;

    // Constructor
    function Company(
        address owner,
        address caleroMain,
        string country,
        string name,
        string address1,
        string address2,
        string city,
        uint postalCode) public {
        company.users[owner] = true;
        company.usersList.push(owner);
        company.caleroMain = caleroMain;
        company.country = country;
        company.name = name;
        company.address1 = address1;
        company.address2 = address2;
        company.city = city;
        company.postalCode = postalCode;
    }

    struct InvoiceDetails {
        address seller;
        address payer;
        uint invoiceId;
        uint payDueDate;
        string item;
        uint quantity;
        uint pricePerUnit;
        uint amountForPay;
        string currency;
        string messageToRecipient;
    }

    // Create a new invoice
    function createInvoice(
        address _payer,
        uint _invoiceId,
        uint _payDueDate,
        string _item,
        uint _quantity,
        uint _pricePerUnit,
        uint _amountForPay,
        string _currency,
        string _messageToRecipient)
    public onlyOwner returns (address) {
        InvoiceDetails memory invoiceDetails;

        invoiceDetails.seller = address(this);
        invoiceDetails.payer = _payer;
        invoiceDetails.invoiceId = _invoiceId;
        invoiceDetails.payDueDate = _payDueDate;
        invoiceDetails.item = _item;
        invoiceDetails.quantity = _quantity;
        invoiceDetails.pricePerUnit = _pricePerUnit;
        invoiceDetails.amountForPay = _amountForPay;
        invoiceDetails.currency = _currency;
        invoiceDetails.messageToRecipient = _messageToRecipient;

        address invoice = new Invoice(
            invoiceDetails.seller,
            invoiceDetails.payer,
            invoiceDetails.invoiceId,
            invoiceDetails.payDueDate,
            invoiceDetails.item,
            invoiceDetails.quantity,
            invoiceDetails.pricePerUnit,
            invoiceDetails.amountForPay,
            invoiceDetails.currency,
            invoiceDetails.messageToRecipient,
            company.caleroMain);

        CaleroMain calero = CaleroMain(company.caleroMain);
        calero.addInvoice(invoice);

        return invoice;
    }

    modifier onlyOwner() {
        require(isOwner(msg.sender));
        _;
    }


    // Add new owner to Company
    function addOwner(address user) public onlyOwner {
        company.users[user] = true;
        company.usersList.push(user);
    }

    // Getters (no fee)
    function isOwner(address user) public constant returns (bool) {
        return company.users[user];
    }

    function listOwners() public constant returns (address[]) {
        return company.usersList;
    }

    function getCountry() public constant returns (string) {
        return company.country;
    }

    function getName() public constant returns (string) {
        return company.name;
    }

    function getAddress1() public constant returns (string) {
        return company.address1;
    }

    function getAddress2() public constant returns (string) {
        return company.address2;
    }

    function getCity() public constant returns (string) {
        return company.city;
    }

    function getPostalCode() public constant returns (uint) {
        return company.postalCode;
    }

    // Setters (need fee)
    function setCountry(string country) public onlyOwner {
        company.country = country;
    }

    function setName(string name) public onlyOwner {
        company.name = name;
    }

    function setAddress1(string address1) public onlyOwner {
        company.address1 = address1;
    }

    function setAddress2(string address2) public onlyOwner {
        company.address2 = address2;
    }

    function setCity(string city) public onlyOwner {
        company.city = city;
    }

    function setPostalCode(uint postalCode) public onlyOwner {
        company.postalCode = postalCode;
    }

    // kill the contract
    function kill() public onlyOwner {
        selfdestruct(msg.sender);
    }

}