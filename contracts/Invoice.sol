pragma solidity ^0.4.18;

import "./SafeMath.sol";

contract Invoice {
    using SafeMath for uint;

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
        string itemDescription;

        string messageToRecipient;

        uint8 state; // State 0 - Pending, 1 - Finished

        mapping (address => SettlementStruct) settlements;
    }

    // Constructor
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
        string _itemDescription,
        string _messageToRecipient,
        address CaleroMain) public
    {
        invoice.owner = _seller;
        invoice.owners.push(_seller);
        invoice.payer = _payer;
        invoice.invoiceId = _invoiceId;
        invoice.issueDate = now;
        invoice.payDueDate = _payDueDate;

        invoice.item = _item;
        invoice.quantity = _quantity;
        invoice.pricePerUnit = _pricePerUnit;
        invoice.itemDescription = _itemDescription;
        invoice.amountForPay = _amountForPay;
        invoice.currency = _currency;

        invoice.messageToRecipient = _messageToRecipient;

        invoice.state = 0;
        invoice.CaleroMain = CaleroMain;
    }

    InvoiceStruct invoice;

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
}