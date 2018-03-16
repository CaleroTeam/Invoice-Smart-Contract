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