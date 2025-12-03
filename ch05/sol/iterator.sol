// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

contract mappingIterator {
    mapping(string => uint256) scores;
    string[] keys;

    function put(string memory _key, uint256 _score) public {
        require(scores[_key] == 0, "_key already exists");
        scores[_key] = _score;
        keys.push(_key);
    }

    function avg() public view returns (uint256) {
        uint256 sum;
        for (uint256 i = 0; i < keys.length; i++) {
            sum += scores[keys[i]];
        }
        return sum / keys.length;
    }
}