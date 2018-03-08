/**
 * @dev Short address attack protection
 */

contract Protection {
    modifier onlyPayloadSize(uint numWords) {
        assert(msg.data.length == numWords * 32 + 4);
        _;
    }
}