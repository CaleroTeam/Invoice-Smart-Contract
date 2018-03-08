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
}