pragma solidity ^0.4.18;

import "./Ownable.sol";

contract CaleroPlatform is Ownable {
    uint nextInvoiceId = 0;

    mapping (address => bool) invoices;
    address[] invoicesList;

    mapping (address => bool) companies;
    address[] companiesList;

    mapping (address => bool) investors;
    address[] investorsList;

    event InvoiceCreated(address invoice);
    event CompanyRegistered(address company);
    event SellerRegistered(address investor);
}