pragma solidity ^0.4.18;

contract Ownable {

    address public owner;
    address public newOwner;

    event OwnerUpdate(address _prevOwner, address _newOwner);

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    function Ownable() public {
        owner = msg.sender;
    }

    // Transfers ownership
    function transferOwnership(address _newOwner) public onlyOwner {
        require(_newOwner != owner);
        newOwner = _newOwner;
    }

    // Accepts transferred ownership
    function acceptOwnership() public {
        require(msg.sender == newOwner);
        OwnerUpdate(owner, newOwner);
        owner = newOwner;
        newOwner = 0x0;
    }

}

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

contract Invoice {

    struct SettlementStruct {
        address seller;
        address payer;
        uint amount;
        uint offerExpiresDate;
        uint payedOnDate;
        uint paid;
    }

    struct InvoiceStruct {
        address caleroMain;
        address owner;
        address[] owners;
        uint invoiceId;
        uint issueDate;
        uint payDueDate;
        address seller;
        address payer;

        // Invoice product/service info
        string item;
        uint quantity;
        uint pricePerUnit;
        uint amountForPay;
        string currency;
        string messageToRecipient;

        uint8 state; // State 0 - Pending, 1 - Finished
        mapping(address => SettlementStruct) settlements;
    }

    InvoiceStruct invoice;

    function Invoice(
        address _seller,
        address _payer,
        uint _invoiceId,
        uint _payDueDate,
        string _item,
        uint _quantity,
        uint _pricePerUnit,
        uint _amountForPay,
        string _currency,
        string _messageToRecipient,
        address caleroMain) public {
        invoice.owner = _seller;
        invoice.owners.push(_seller);
        invoice.payer = _payer;
        invoice.invoiceId = _invoiceId;
        invoice.issueDate = now;
        invoice.payDueDate = _payDueDate;

        invoice.item = _item;
        invoice.quantity = _quantity;
        invoice.pricePerUnit = _pricePerUnit;
        invoice.amountForPay = _amountForPay;
        invoice.currency = _currency;

        invoice.messageToRecipient = _messageToRecipient;

        invoice.state = 0;
        invoice.caleroMain = caleroMain;
    }

    // Events
    event InvoiceClosed(uint time);
    event WithdrawMoney(address owner, uint time);
    event CommentSent(address company, string message);
    event OwnerChanged(address oldValue, address newValue);
    event CostumerChanged(address oldValue, address newValue);
    event InvoiceIdChanged(uint oldValue, uint newValue);
    event PayDueDateChanged(uint oldValue, uint newValue);
    event ItemChanged(string oldValue, string newValue);
    event QuantityChanged(uint oldValue, uint newValue);
    event PricePerUnitChanged(uint oldValue, uint newValue);
    event AmountForTransferChanged(uint oldValue, uint newValue);
    event CurrencyChanged(string oldValue, string newValue);
    event MessageToRecipientChanged(string oldValue, string newValue);

    // Modifiers
    modifier onlyBuyer(address payer) {
        require(payer == invoice.payer && msg.sender == invoice.payer);
        _;
    }
    modifier onlyOwner(address owner) {
        require(owner == invoice.owner && msg.sender == invoice.owner);
        _;
    }
    modifier onPending() {
        require(invoice.state == 0);
        _;
    }

    // Actions
    function buyInvoice(address payer) public onlyBuyer(payer) payable {
        require(invoice.state == 0); // on pending
        require(invoice.payDueDate != 0);

        // The order's value must be equal to msg.value and must be more then 0
        require(msg.value != 0);
        require(invoice.amountForPay == msg.value);

        SettlementStruct memory settlement;

        settlement.seller = invoice.owner;
        settlement.payer = payer;
        settlement.amount = invoice.amountForPay;
        settlement.offerExpiresDate = invoice.payDueDate;
        settlement.payedOnDate = now;
        settlement.paid = msg.value;

        invoice.settlements[invoice.owner] = settlement;

        markAsFinished();
        InvoiceClosed(now);
    }

    // Owner withdrawal money from sc
    function withdrawMoney(address owner) public onlyOwner(owner) {
        require(invoice.settlements[invoice.owner].paid != 0);

        owner.transfer(invoice.settlements[invoice.owner].paid);
        WithdrawMoney(owner, now);
    }

    // Buyer can send comment to seller
    function sendComments(address payer, string message) onlyBuyer(payer) public {
        /// Trigger the event
        CommentSent(payer, message);
    }

    // Mark invoice as finished
    function markAsFinished() private {
        invoice.state = 1;
    }

    // Getters
    function getOwner() public constant returns (address) {
        return invoice.owner;
    }

    function listOwners() public constant returns (address[]) {
        return invoice.owners;
    }

    function getCustomer() public constant returns (address) {
        return invoice.payer;
    }

    function getInvoiceId() public constant returns (uint) {
        return invoice.invoiceId;
    }

    function getIssueDate() public constant returns (uint) {
        return invoice.issueDate;
    }

    function getPayDueDate() public constant returns (uint) {
        return invoice.payDueDate;
    }

    function getItem() public constant returns (string) {
        return invoice.item;
    }

    function getQuantity() public constant returns (uint) {
        return invoice.quantity;
    }

    function getPricePerUnit() public constant returns (uint) {
        return invoice.pricePerUnit;
    }

    function getAmount() public constant returns (uint) {
        return invoice.amountForPay;
    }

    function getCurrency() public constant returns (string) {
        return invoice.currency;
    }

    function getMessageToRecipient() public constant returns (string) {
        return invoice.messageToRecipient;
    }

    function getState() public constant returns (uint8) {
        return invoice.state;
    }

    // Setter
    function changeOwner(address owner, address newOwner) public onlyOwner(owner) {
        if (invoice.owner != newOwner) {
            invoice.owners.push(newOwner);
        }
        invoice.owner = newOwner;
        OwnerChanged(owner, newOwner);
    }

    function setCustomer(address owner, address payer) public onPending onlyOwner(owner) {
        CostumerChanged(invoice.payer, payer);
        invoice.payer = payer;
    }

    function setInvoiceId(address owner, uint invoiceId) public onPending onlyOwner(owner) {
        InvoiceIdChanged(invoice.invoiceId, invoiceId);
        invoice.invoiceId = invoiceId;
    }

    function setPayDueDate(address owner, uint payDueDate) public onPending onlyOwner(owner) {
        PayDueDateChanged(invoice.payDueDate, payDueDate);
        invoice.payDueDate = payDueDate;
    }

    function setItem(address owner, string item) public onPending onlyOwner(owner) {
        ItemChanged(invoice.item, item);
        invoice.item = item;
    }

    function setQuantity(address owner, uint quantity) public onPending onlyOwner(owner) {
        QuantityChanged(invoice.quantity, quantity);
        invoice.quantity = quantity;
    }

    function setPricePerUnit(address owner, uint pricePerUnit) public onPending onlyOwner(owner) {
        PricePerUnitChanged(invoice.pricePerUnit, pricePerUnit);
        invoice.pricePerUnit = pricePerUnit;
    }

    function setAmount(address owner, uint amount) public onPending onlyOwner(owner) {
        AmountForTransferChanged(invoice.amountForPay, amount);
        invoice.amountForPay = amount;
    }

    function setCurrency(address owner, string currency) public onPending onlyOwner(owner) {
        CurrencyChanged(invoice.currency, currency);
        invoice.currency = currency;
    }

    function setMessageToRecipient(address owner, string messageToRecipient) public onPending onlyOwner(owner) {
        MessageToRecipientChanged(invoice.messageToRecipient, messageToRecipient);
        invoice.messageToRecipient = messageToRecipient;
    }

    // kill the contract
    function kill(address owner) public onlyOwner(owner) {
        selfdestruct(owner);
    }

}
