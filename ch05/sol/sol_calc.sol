// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract gas_calc {
    function gasOperations(uint num) public view returns (uint256 remainingGas) {
        uint256 startGas = gasleft();
        
        uint256 someValue = 0;
        for (uint i = 0; i < num; i++) {
            someValue += i;
        }
        
        uint256 endGas = gasleft();
        return startGas - endGas;
    }
}