pragma solidity ^0.4.18;

import "./CaleroPlatform.sol";
import "./Company.sol";
import "./Seller.sol";

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