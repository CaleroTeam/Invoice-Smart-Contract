# Invoice smart contract
[![Platform](https://img.shields.io/badge/Platform-Ethereum-brightgreen.svg)](https://en.wikipedia.org/wiki/Ethereum)
[![Platform](https://img.shields.io/badge/Compiler-^0.4.18-yellow.svg)](http://solidity.readthedocs.io/en/v0.4.18/)

## Description
Calero platform DApp is <a
        href="https://en.wikipedia.org/wiki/Ethereum">Ethereum</a> blockchain based solution for invoicing management.

## Smart contracts :computer:

* Ownable
* CaleroMain (Main)
* Company
* Invoice

## ABI

<details>
    <summary>CaleroMain</summary>
    <pre>[ { "constant": false, "inputs": [], "name": "kill", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": true, "inputs": [], "name": "listCompanies", "outputs": [ { "name": "", "type": "address[]" } ], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": false, "inputs": [ { "name": "country", "type": "string" }, { "name": "name", "type": "string" }, { "name": "address1", "type": "string" }, { "name": "address2", "type": "string" }, { "name": "city", "type": "string" }, { "name": "postalCode", "type": "uint256" } ], "name": "createCompany", "outputs": [ { "name": "", "type": "address" } ], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": true, "inputs": [], "name": "listInvoices", "outputs": [ { "name": "", "type": "address[]" } ], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": false, "inputs": [ { "name": "invoice", "type": "address" } ], "name": "addInvoice", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": false, "inputs": [], "name": "acceptOwnership", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": true, "inputs": [], "name": "owner", "outputs": [ { "name": "", "type": "address" } ], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": true, "inputs": [], "name": "newOwner", "outputs": [ { "name": "", "type": "address" } ], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": false, "inputs": [ { "name": "_newOwner", "type": "address" } ], "name": "transferOwnership", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "anonymous": false, "inputs": [ { "indexed": false, "name": "invoice", "type": "address" } ], "name": "InvoiceCreated", "type": "event" }, { "anonymous": false, "inputs": [ { "indexed": false, "name": "company", "type": "address" } ], "name": "CompanyRegistered", "type": "event" }, { "anonymous": false, "inputs": [ { "indexed": false, "name": "_prevOwner", "type": "address" }, { "indexed": false, "name": "_newOwner", "type": "address" } ], "name": "OwnerUpdate", "type": "event" } ]</pre>
</details>
<details>
    <summary>Company</summary>
    <pre> [ { "constant": false, "inputs": [ { "name": "postalCode", "type": "uint256" } ], "name": "setPostalCode", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": true, "inputs": [], "name": "getCity", "outputs": [ { "name": "", "type": "string" } ], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": false, "inputs": [ { "name": "_payer", "type": "address" }, { "name": "_invoiceId", "type": "uint256" }, { "name": "_payDueDate", "type": "uint256" }, { "name": "_item", "type": "string" }, { "name": "_quantity", "type": "uint256" }, { "name": "_pricePerUnit", "type": "uint256" }, { "name": "_amountForPay", "type": "uint256" }, { "name": "_currency", "type": "string" }, { "name": "_messageToRecipient", "type": "string" } ], "name": "createInvoice", "outputs": [ { "name": "", "type": "address" } ], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": true, "inputs": [], "name": "getName", "outputs": [ { "name": "", "type": "string" } ], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": true, "inputs": [ { "name": "user", "type": "address" } ], "name": "isOwner", "outputs": [ { "name": "", "type": "bool" } ], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": false, "inputs": [], "name": "kill", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": true, "inputs": [], "name": "getAddress2", "outputs": [ { "name": "", "type": "string" } ], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": false, "inputs": [ { "name": "address2", "type": "string" } ], "name": "setAddress2", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": false, "inputs": [ { "name": "user", "type": "address" } ], "name": "addOwner", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": true, "inputs": [], "name": "getAddress1", "outputs": [ { "name": "", "type": "string" } ], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": true, "inputs": [], "name": "getCountry", "outputs": [ { "name": "", "type": "string" } ], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": false, "inputs": [ { "name": "name", "type": "string" } ], "name": "setName", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": false, "inputs": [ { "name": "country", "type": "string" } ], "name": "setCountry", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": false, "inputs": [ { "name": "address1", "type": "string" } ], "name": "setAddress1", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": true, "inputs": [], "name": "listOwners", "outputs": [ { "name": "", "type": "address[]" } ], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": true, "inputs": [], "name": "getPostalCode", "outputs": [ { "name": "", "type": "uint256" } ], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": false, "inputs": [ { "name": "city", "type": "string" } ], "name": "setCity", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "inputs": [ { "name": "owner", "type": "address" }, { "name": "caleroMain", "type": "address" }, { "name": "country", "type": "string" }, { "name": "name", "type": "string" }, { "name": "address1", "type": "string" }, { "name": "address2", "type": "string" }, { "name": "city", "type": "string" }, { "name": "postalCode", "type": "uint256" } ], "payable": false, "stateMutability": "nonpayable", "type": "constructor" } ] </pre>
</details>
<details>
    <summary>Invoice</summary>
    <pre> [ { "constant": true, "inputs": [], "name": "getQuantity", "outputs": [ { "name": "", "type": "uint256" } ], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": false, "inputs": [ { "name": "payer", "type": "address" } ], "name": "buyInvoice", "outputs": [], "payable": true, "stateMutability": "payable", "type": "function" }, { "constant": true, "inputs": [], "name": "getState", "outputs": [ { "name": "", "type": "uint8" } ], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": false, "inputs": [ { "name": "payer", "type": "address" }, { "name": "message", "type": "string" } ], "name": "sendComments", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": false, "inputs": [ { "name": "owner", "type": "address" }, { "name": "payer", "type": "address" } ], "name": "setCustomer", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": false, "inputs": [ { "name": "owner", "type": "address" } ], "name": "withdrawMoney", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": true, "inputs": [], "name": "getInvoiceId", "outputs": [ { "name": "", "type": "uint256" } ], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": false, "inputs": [ { "name": "owner", "type": "address" }, { "name": "payDueDate", "type": "uint256" } ], "name": "setPayDueDate", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": false, "inputs": [ { "name": "owner", "type": "address" }, { "name": "item", "type": "string" } ], "name": "setItem", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": true, "inputs": [], "name": "getCustomer", "outputs": [ { "name": "", "type": "address" } ], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": true, "inputs": [], "name": "getCurrency", "outputs": [ { "name": "", "type": "string" } ], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": false, "inputs": [ { "name": "owner", "type": "address" }, { "name": "messageToRecipient", "type": "string" } ], "name": "setMessageToRecipient", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": true, "inputs": [], "name": "getOwner", "outputs": [ { "name": "", "type": "address" } ], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": true, "inputs": [], "name": "getMessageToRecipient", "outputs": [ { "name": "", "type": "string" } ], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": false, "inputs": [ { "name": "owner", "type": "address" }, { "name": "currency", "type": "string" } ], "name": "setCurrency", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": true, "inputs": [], "name": "getPayDueDate", "outputs": [ { "name": "", "type": "uint256" } ], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": true, "inputs": [], "name": "getPricePerUnit", "outputs": [ { "name": "", "type": "uint256" } ], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": false, "inputs": [ { "name": "owner", "type": "address" }, { "name": "quantity", "type": "uint256" } ], "name": "setQuantity", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": true, "inputs": [], "name": "getItem", "outputs": [ { "name": "", "type": "string" } ], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": false, "inputs": [ { "name": "owner", "type": "address" } ], "name": "kill", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": false, "inputs": [ { "name": "owner", "type": "address" }, { "name": "amount", "type": "uint256" } ], "name": "setAmount", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": true, "inputs": [], "name": "getAmount", "outputs": [ { "name": "", "type": "uint256" } ], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": true, "inputs": [], "name": "getIssueDate", "outputs": [ { "name": "", "type": "uint256" } ], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": false, "inputs": [ { "name": "owner", "type": "address" }, { "name": "invoiceId", "type": "uint256" } ], "name": "setInvoiceId", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": false, "inputs": [ { "name": "owner", "type": "address" }, { "name": "pricePerUnit", "type": "uint256" } ], "name": "setPricePerUnit", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": true, "inputs": [], "name": "listOwners", "outputs": [ { "name": "", "type": "address[]" } ], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": false, "inputs": [ { "name": "owner", "type": "address" }, { "name": "newOwner", "type": "address" } ], "name": "changeOwner", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "inputs": [ { "name": "_seller", "type": "address" }, { "name": "_payer", "type": "address" }, { "name": "_invoiceId", "type": "uint256" }, { "name": "_payDueDate", "type": "uint256" }, { "name": "_item", "type": "string" }, { "name": "_quantity", "type": "uint256" }, { "name": "_pricePerUnit", "type": "uint256" }, { "name": "_amountForPay", "type": "uint256" }, { "name": "_currency", "type": "string" }, { "name": "_messageToRecipient", "type": "string" }, { "name": "caleroMain", "type": "address" } ], "payable": false, "stateMutability": "nonpayable", "type": "constructor" }, { "anonymous": false, "inputs": [ { "indexed": false, "name": "time", "type": "uint256" } ], "name": "InvoiceClosed", "type": "event" }, { "anonymous": false, "inputs": [ { "indexed": false, "name": "owner", "type": "address" }, { "indexed": false, "name": "time", "type": "uint256" } ], "name": "WithdrawMoney", "type": "event" }, { "anonymous": false, "inputs": [ { "indexed": false, "name": "company", "type": "address" }, { "indexed": false, "name": "message", "type": "string" } ], "name": "CommentSent", "type": "event" }, { "anonymous": false, "inputs": [ { "indexed": false, "name": "oldValue", "type": "address" }, { "indexed": false, "name": "newValue", "type": "address" } ], "name": "OwnerChanged", "type": "event" }, { "anonymous": false, "inputs": [ { "indexed": false, "name": "oldValue", "type": "address" }, { "indexed": false, "name": "newValue", "type": "address" } ], "name": "CostumerChanged", "type": "event" }, { "anonymous": false, "inputs": [ { "indexed": false, "name": "oldValue", "type": "uint256" }, { "indexed": false, "name": "newValue", "type": "uint256" } ], "name": "InvoiceIdChanged", "type": "event" }, { "anonymous": false, "inputs": [ { "indexed": false, "name": "oldValue", "type": "uint256" }, { "indexed": false, "name": "newValue", "type": "uint256" } ], "name": "PayDueDateChanged", "type": "event" }, { "anonymous": false, "inputs": [ { "indexed": false, "name": "oldValue", "type": "string" }, { "indexed": false, "name": "newValue", "type": "string" } ], "name": "ItemChanged", "type": "event" }, { "anonymous": false, "inputs": [ { "indexed": false, "name": "oldValue", "type": "uint256" }, { "indexed": false, "name": "newValue", "type": "uint256" } ], "name": "QuantityChanged", "type": "event" }, { "anonymous": false, "inputs": [ { "indexed": false, "name": "oldValue", "type": "uint256" }, { "indexed": false, "name": "newValue", "type": "uint256" } ], "name": "PricePerUnitChanged", "type": "event" }, { "anonymous": false, "inputs": [ { "indexed": false, "name": "oldValue", "type": "uint256" }, { "indexed": false, "name": "newValue", "type": "uint256" } ], "name": "AmountForTransferChanged", "type": "event" }, { "anonymous": false, "inputs": [ { "indexed": false, "name": "oldValue", "type": "string" }, { "indexed": false, "name": "newValue", "type": "string" } ], "name": "CurrencyChanged", "type": "event" }, { "anonymous": false, "inputs": [ { "indexed": false, "name": "oldValue", "type": "string" }, { "indexed": false, "name": "newValue", "type": "string" } ], "name": "MessageToRecipientChanged", "type": "event" } ] </pre>
</details>

## Functions :wrench:

### CaleroMain SC:

* `addInvoice( address invoice)`
* `listInvoices()`
* `createCompany(string country, string name, string address1, string address2, string city, uint postalCode)`
* `listCompanies()`
* `kill()`

### Company SC:

* `createInvoice( address _payer, uint _invoiceId, uint _payDueDate, string _item, uint _quantity, uint _pricePerUnit, uint _amountForPay, string _currency, string _messageToRecipient)`
* `addOwner(address user)`
* `isOwner(address user)`
* `listOwners()`
* `getCountry()`
* `getName()`
* `getAddress1()`
* `getAddress2()`
* `getCity()`
* `getPostalCode()`
* `setCountry()`
* `setName()`
* `setAddress1()`
* `setAddress2()`
* `setCity()`
* `setPostalCode()`
* `kill()`


### Invoice SC:

* `buyInvoice(address payer)`
* `withdrawMoney(address owner)`
* `sendComments(address payer, string message)`
* `markAsFinished()`
* `getOwner()`
* `listOwners()`
* `getCustomer()`
* `getInvoiceId()`
* `getIssueDate()`
* `getPayDueDate()`
* `getItem()`
* `getQuantity()`
* `getPricePerUnit()`
* `getAmount()`
* `getCurrency()`
* `getMessageToRecipient()`
* `getState()`
* `getOwner()`
* `changeOwner(address owner, address newOwner)`
* `setCustomer(address owner, address costumer)`
* `setInvoiceId(address owner, uint id)`
* `setIssueDate(address owner, uint issuedate)`
* `setPayDueDate(address owner, uint payDueDate)`
* `setItem(address owner, string item)`
* `setQuantity(address owner, uint quantity)`
* `setPricePerUnit(address owner, uint pricePerUnit)`
* `setAmount(address owner, uint newAmount)`
* `setCurrency(address owner, string currenct)`
* `setMessageToRecipient(address owner, string message)`
* `kill()`


