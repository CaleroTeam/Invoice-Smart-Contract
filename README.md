# Invoice smart contract
[![Platform](https://img.shields.io/badge/Platform-Ethereum-brightgreen.svg)](https://en.wikipedia.org/wiki/Ethereum)
[![Platform](https://img.shields.io/badge/Compiler-^0.4.18-yellow.svg)](http://solidity.readthedocs.io/en/v0.4.18/)

## Description
Calero platform DApp is <a
        href="https://en.wikipedia.org/wiki/Ethereum">Ethereum</a> blockchain based solution for invoicing management.

## Smart contracts :computer:

* Ownable
* CaleroMain (Main)

## ABI

<details>
    <summary>CaleroMain</summary>
    <pre>[{"constant":true,"inputs":[{"name":"","type":"address"}],"name":"balances","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"backEnd","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[],"name":"renounceOwnership","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"owner","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"backEndUser","type":"address"}],"name":"setBackEndUser","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"newOwner","type":"address"}],"name":"transferOwnership","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"anonymous":false,"inputs":[{"indexed":true,"name":"previousOwner","type":"address"}],"name":"OwnershipRenounced","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"name":"backEndAddress","type":"address"}],"name":"BackEndUserAdded","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"name":"previousOwner","type":"address"},{"indexed":true,"name":"newOwner","type":"address"}],"name":"OwnershipTransferred","type":"event"},{"constant":false,"inputs":[{"name":"fromAddress","type":"address"},{"name":"amount","type":"uint256"},{"name":"message","type":"string"}],"name":"addInvoice","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"id","type":"uint256"}],"name":"viewInvoice","outputs":[{"name":"","type":"address"},{"name":"","type":"address"},{"name":"","type":"uint256"},{"name":"","type":"string"},{"name":"","type":"bool"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"buyerAddress","type":"address"},{"name":"idx","type":"uint256"}],"name":"getIncomingInvoices","outputs":[{"name":"","type":"uint256"},{"name":"","type":"address"},{"name":"","type":"uint256"},{"name":"","type":"string"},{"name":"","type":"bool"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"buyerAddress","type":"address"}],"name":"numberOfIncomingInvoices","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"sellerAddress","type":"address"},{"name":"idx","type":"uint256"}],"name":"getOutgoingInvoice","outputs":[{"name":"","type":"uint256"},{"name":"","type":"address"},{"name":"","type":"uint256"},{"name":"","type":"string"},{"name":"","type":"bool"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"sellerAddress","type":"address"}],"name":"numberOfOutgoingInvoices","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"id","type":"uint256"}],"name":"pay","outputs":[],"payable":true,"stateMutability":"payable","type":"function"},{"constant":false,"inputs":[],"name":"withdraw","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"}]</pre>
</details>

## Functions :wrench:

### CaleroMain SC:

* `addInvoice( address fromAddress, uint amount, string message)`
* `viewInvoice(uint id)`
* `getIncomingInvoices(address buyerAddress, uint idx)`
* `numberOfIncomingInvoices(address buyerAddress)`
* `getOutgoingInvoice(address sellerAddress, uint idx)`
* `numberOfOutgoingInvoices(address sellerAddress)`
* `pay(uint id)`
* `withdraw()`

### Ownable SC:

* `transferOwnership(address newOwner)`
* `setBackEndUser(address backEndUser)`
* `renounceOwnership()`