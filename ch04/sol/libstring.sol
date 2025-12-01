// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

library libstring {
    function isEqual(string memory a, string memory b) internal pure returns(bool) {
        bytes memory aa = bytes(a);
        bytes memory bb = bytes(b);
        if (aa.length != bb.length) return false;
        for (uint256 i = 0; i < aa.length; i++) {
            if (aa[i] != bb[i]) return false;
        }
        return true;
    }

    function strcat(string memory a, string memory b) internal pure returns(string memory) {
        bytes memory aa = bytes(a);
        bytes memory bb = bytes(b);
        bytes memory abstr = new bytes(aa.length + bb.length);
        for (uint256 i = 0; i < aa.length; i++) {
            abstr[i] = aa[i];
        }
        for (uint256 i = 0; i < bb.length; i++) {
            abstr[aa.length + i] = bb[i];
        }
        return string(abstr);
    }
}