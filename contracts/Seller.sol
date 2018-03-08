pragma solidity ^0.4.18;

import "./Operations.sol";

contract Seller is Operations {

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

    SellerStruct seller;

    // Constructor
    function Seller(address owner, address CaleroMain, bytes32 country, bytes32 name, bytes32 addressStreet, bytes32 city, bytes32 postalCode) public {
        seller.users[owner] = true;
        seller.usersList.push(owner);
        seller.CaleroMain = CaleroMain;
        seller.country = country;
        seller.name = name;
        seller.addressStreet = addressStreet;
        seller.city = city;
        seller.postalCode = postalCode;
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
        string itemDescription;
        string messageToRecipient;
    }

    // Create new Invoice for company
    function createInvoice(
        address _payer,
        uint _invoiceId,
        uint _payDueDate,
        string _item,
        uint _quantity,
        uint _pricePerUnit,
        uint _amountForPay,
        string _currency,
        string _itemDescription,
        string _messageToRecipient)
    public onlyOwner {
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
        invoiceDetails.itemDescription = _itemDescription;
        invoiceDetails.messageToRecipient = _messageToRecipient;

        createInvoiceCall(invoiceDetails);
    }

    function createInvoiceCall(InvoiceDetails invoiceDetails) private returns (address) {
        address invoice = new Invoice(invoiceDetails.seller, invoiceDetails.payer, invoiceDetails.invoiceId, invoiceDetails.payDueDate, invoiceDetails.item, invoiceDetails.quantity, invoiceDetails.pricePerUnit, invoiceDetails.amountForPay, invoiceDetails.currency, invoiceDetails.itemDescription, invoiceDetails.messageToRecipient, seller.CaleroMain);

        CaleroPlatform calero = CaleroPlatform(seller.CaleroMain);
        calero.addInvoice(invoice);

        return invoice;
    }

    // Modifiers
    modifier onlyOwner() {
        require(isOwner(msg.sender));
        _;
    }

    // Add new owner to Seller
    function addOwner(address user) public onlyOwner {
        seller.users[user] = true;
        seller.usersList.push(user);
    }

    // Remove existing owner from Seller
    function removeOwner(address user) public onlyOwner {
        seller.users[user] = false;
        seller.usersList = removeItem(seller.usersList, user);
    }

    // Check if address is owner
    function isOwner(address user) public constant returns (bool) {
        return seller.users[user];
    }

    // List of seller all owners
    function listOwners() public constant returns(address[]) {
        return seller.usersList;
    }

    // Sets seller country
    function setCountry(bytes32 country) public onlyOwner {
        seller.country = country;
    }

    // Sets seller name
    function setName(bytes32 name) public onlyOwner {
        seller.name = name;
    }

    // Sets seller addressStreet
    function setAddressStreet(bytes32 addressStreet) public onlyOwner {
        seller.addressStreet = addressStreet;
    }

    // Sets seller city
    function setCity(bytes32 city) public onlyOwner {
        seller.city = city;
    }

    // Sets seller postalCode
    function setPostalCode(bytes32 postalCode) public onlyOwner {
        seller.postalCode = postalCode;
    }

    // Returns seller country
    function getCountry() public constant returns (bytes32) {
        return seller.country;
    }

    // Returns seller name
    function getName() public constant returns (bytes32) {
        return seller.name;
    }

    // Returns seller address1
    function getAddressStreet() public constant returns (bytes32) {
        return seller.addressStreet;
    }

    // Returns seller city
    function getCity() public constant returns (bytes32) {
        return seller.city;
    }

    // Returns seller postalCode
    function getPostalCode() public constant returns (bytes32) {
        return seller.postalCode;
    }

    /*
    * @dev kill the contract functionality
    */
    function kill() public onlyOwner {
        selfdestruct(msg.sender);
    }
}