//SPDX-License-Identifier: MIT

pragma solidity 0.8.26; // This is my Second Contract!

contract EvenOddRefund {
    
    // External payable function that takes a uint as input
    function processNumber(uint256 number) external payable {
        // First, special case: if number is 9, revert
        if (number == 9) {
            revert("We don't like 9");
        }

        uint256 refundAmount;

        // Check if number is even
        if (number % 2 == 0) {
            // Refund half of the sent Ether
            refundAmount = msg.value / 2;
        } else {
            // Refund all the sent Ether
            refundAmount = msg.value;
        }

        // Send the refund
        (bool success, ) = msg.sender.call{value: refundAmount}("");
        require(success, "Refund failed");
    }

    // Allow contract to receive Ether (just in case)
    receive() external payable {}
}

