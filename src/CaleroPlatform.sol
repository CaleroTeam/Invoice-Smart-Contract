pragma solidity ^0.4.18;

/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions".
 */
contract Ownable {
    address public owner;
    address public newOwner;

    event OwnerUpdate(address _prevOwner, address _newOwner);

    function Ownable() public {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    /**
     * @dev Transfers ownership. New owner has to accept in order ownership change to take effect
     */
    function transferOwnership(address _newOwner) public onlyOwner {
        require(_newOwner != owner);
        newOwner = _newOwner;
    }

    /**
     * @dev Accepts transferred ownership
     */
    function acceptOwnership() public {
        require(msg.sender == newOwner);
        OwnerUpdate(owner, newOwner);
        owner = newOwner;
        newOwner = 0x0;
    }
}

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

    // constructor
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
        invoiceDetails.messageToRecipient = _messageToRecipient;

        createInvoiceCall(invoiceDetails);
    }

    function createInvoiceCall(InvoiceDetails invoiceDetails) private returns (address) {
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
            seller.CaleroMain);

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
    }

    /*
    * @dev kill the contract functionality
    */
    function kill() public onlyOwner {
        selfdestruct(owner);
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
        address CaleroMain;

        // Company owner
        address owner;
        address[] owners;

        // Base info
        uint invoiceId;
        uint issueDate;
        uint payDueDate;

        // Buyer/Seller
        address seller; // seller
        address payer; // payer

        // Invoice product/service info
        string item;
        uint quantity;
        uint pricePerUnit;
        uint amountForPay;
        string currency;

        string messageToRecipient;

        uint8 state; // State 0 - Pending, 1 - Finished

        mapping (address => SettlementStruct) settlements;
    }

    function Invoice(address _seller, address _payer, uint _invoiceId, uint _payDueDate, string _item, uint _quantity, uint _pricePerUnit, uint _amountForPay, string _currency, string _messageToRecipient, address CaleroMain) public {
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
        invoice.CaleroMain = CaleroMain;
    }

    InvoiceStruct invoice;

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
    function withdrawMoney(address owner) public onlyOwner(owner){
        require(invoice.settlements[invoice.owner].paid != 0);

        owner.transfer(invoice.settlements[invoice.owner].paid);
        WithdrawMoney(owner, now);
    }

    // Buyer can send comment to seller
    function sendComments(address payer, string message) onlyBuyer(payer) public {
        /// Trigger the event
        CommentSent(payer, message);
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

    // Getters
    function getOwner() public constant returns (address) {
        return invoice.owner;
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

    // Mark invoice as finished
    function markAsFinished() private {
        invoice.state = 1;
    }

    /*
    * @dev  kill the contract functionality
    */
    function kill(address owner) public onlyOwner(owner) {
        selfdestruct(owner);
    }
}