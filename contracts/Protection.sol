/**
 * @dev Short address attack protection
 */
pragma solidity ^0.4.18;

contract Protection {
    modifier onlyPayloadSize(uint numWords) {
        assert(msg.data.length == numWords * 32 + 4);
        _;
    }
}