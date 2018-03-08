/*
*  Operations with arrays
*/

contract Operations {
    /**
     * Remove provided item from provided array
     */
    function removeItem(address[] array, address item) internal pure returns(address[] value) {
        address[] memory arrayNew = new address[](array.length - 1);
        uint8 j = 0;
        for (uint i = 0; i < array.length; i++) {
            if (array[i] != item) {
                arrayNew[j] = array[i];
                j++;
            }
        }
        delete array;
        return arrayNew;
    }

    /**
     * Remove provided item from provided array
     */
    function removeItem(address[2][] array, address[2] item) internal pure returns(address[2][] value) {
        address[2][] memory arrayNew = new address[2][](array.length - 1);
        uint8 j = 0;
        for (uint i = 0; i < array.length; i++) {
            if (array[i][0] != item[0] && array[i][1] != item[1]) {
                arrayNew[j] = array[i];
                j++;
            }
        }
        delete array;
        return arrayNew;
    }
}