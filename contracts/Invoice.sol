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
}