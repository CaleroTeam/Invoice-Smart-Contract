pragma solidity ^0.4.23;

import "./Ownable.sol";

/**
* @title CaleroMain
* @dev Calero platform main smart contract.
*/
contract CaleroMain is Ownable {
    struct Invoice {
        address seller;
        address buyer;
        uint amount;
        string message;
        bool paid;
    }
    
    Invoice[] internal invoices;
    
    mapping (address => uint[]) internal sellers;
    mapping (address => uint[]) internal buyers;
    mapping (address => uint) public balances;
    
    function addInvoice(address fromAddress, uint amount, string message) public {
        Invoice memory inv = Invoice({
            buyer: fromAddress,
            seller: msg.sender, 
            amount: amount,
            message: message,
            paid: false
        });
        

        invoices.push(inv);
        sellers[inv.seller].push(invoices.length - 1);
        buyers[inv.buyer].push(invoices.length - 1);
    }
    
    function viewInvoice(uint id) public onlyBackEnd view returns(address, address, uint, string, bool) {
        Invoice memory inv = invoices[id];
        return (inv.seller, inv.buyer, inv.amount, inv.message, inv.paid);
    }
    
    
    function getIncomingInvoices(address buyerAddress, uint idx) public onlyBackEnd view returns (uint, address, uint, string, bool) {
        Invoice memory inv = invoices[ buyers[buyerAddress][idx] ];
        return (buyers[buyerAddress][idx], inv.buyer, inv.amount, inv.message, inv.paid);
    }
    
    function numberOfIncomingInvoices(address buyerAddress) public onlyBackEnd view returns (uint) {
        return buyers[buyerAddress].length;
    }


    function getOutgoingInvoice(address sellerAddress, uint idx) public onlyBackEnd view returns (uint, address, uint, string, bool) {
        Invoice memory inv = invoices[ sellers[sellerAddress][idx] ];
        return (sellers[sellerAddress][idx], inv.buyer, inv.amount, inv.message, inv.paid);
    }
    
    function numberOfOutgoingInvoices(address sellerAddress) public onlyBackEnd view returns (uint) {
        return sellers[sellerAddress].length;
    }
    
    
    function pay(uint id) public payable {
        Invoice storage inv = invoices[id];
        
        require(inv.paid == false);
        require(inv.buyer == msg.sender);
        require(msg.value == inv.amount);
        
        inv.paid = true;
        balances[inv.seller] += msg.value;
    }
    
    function withdraw() public {
        require(balances[msg.sender] != 0);
        
        uint toWithdraw = balances[msg.sender];
        balances[msg.sender] = 0;
        msg.sender.transfer(toWithdraw);
    }

}